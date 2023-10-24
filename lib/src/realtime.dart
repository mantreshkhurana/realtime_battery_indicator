import 'dart:async';
import 'package:realtime_battery_indicator/realtime_battery_indicator.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/cupertino.dart';

String batteryStateText = 'Unknown';
int batteryLevel = 0;
BatteryState batteryState = BatteryState.unknown;
final Battery battery = Battery();
final StreamController<int> batteryLevelController = StreamController<int>();

Widget getBatteryState() {
  return StreamBuilder<BatteryState>(
    stream: battery.onBatteryStateChanged,
    initialData: BatteryState.unknown,
    builder: (context, snapshot) {
      final state = snapshot.data;

      if (state == BatteryState.full) {
        batteryStateText = 'Full';
        batteryState = BatteryState.full;
      } else if (state == BatteryState.charging) {
        batteryStateText = 'Charging';
        batteryState = BatteryState.charging;
      } else if (state == BatteryState.discharging) {
        batteryStateText = 'Discharging';
        batteryState = BatteryState.discharging;
      }

      return Text(batteryStateText);
    },
  );
}

Future<void> updateBatteryLevel() async {
  int level = await battery.batteryLevel;
  batteryLevelController.add(level);
}

Widget getBatteryLevel() {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    updateBatteryLevel();
  });
  return StreamBuilder<int>(
    stream: batteryLevelController.stream,
    initialData: batteryLevel,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        batteryLevel = snapshot.data!;
        return Text(
          'Battery level: ${snapshot.data}%',
        );
      } else if (snapshot.hasError) {
        return Text('Error getting battery level: ${snapshot.error}');
      } else {
        return const Text('Loading battery level...');
      }
    },
  );
}

/// [BatteryIndicator] is a widget that displays the battery level and status.
class BatteryIndicator extends StatefulWidget {
  /// [showBatteryLevel] is a boolean that determines whether to show the battery level.
  final bool showBatteryLevel;

  /// [textStyle] is a TextStyle that determines the style of the battery level.
  final TextStyle textStyle;

  /// [size] is a double that determines the size of the battery indicator.
  final double size;

  final Duration duration;

  const BatteryIndicator({
    super.key,
    this.showBatteryLevel = true,
    this.textStyle = const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
    ),
    this.size = 12.0,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  // ignore: library_private_types_in_public_api
  _BatteryIndicatorState createState() => _BatteryIndicatorState();
}

class _BatteryIndicatorState extends State<BatteryIndicator> {
  int batteryLevel = 0;
  BatteryState batteryState = BatteryState.unknown;
  StreamController<int> batteryLevelController = StreamController<int>();
  StreamSubscription<BatteryState>? batteryStateSubscription;

  @override
  void initState() {
    super.initState();

    batteryStateSubscription =
        battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        batteryState = state;
      });
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateBatteryLevel();
    });
  }

  @override
  void dispose() {
    batteryStateSubscription?.cancel();
    batteryLevelController.close();
    super.dispose();
  }

  Future<void> updateBatteryLevel() async {
    int level = await battery.batteryLevel;
    batteryLevelController.add(level);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: batteryLevelController.stream,
      initialData: batteryLevel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          batteryLevel = snapshot.data!;
          return Row(
            children: [
              widget.showBatteryLevel
                  ? Text(
                      '${snapshot.data}%',
                      style: widget.textStyle,
                    )
                  : const SizedBox(),
              const SizedBox(
                width: 5,
              ),
              DefaultBatteryIndicator(
                status: DefaultBatteryStatus(
                  value: snapshot.data!,
                  type: batteryState == BatteryState.charging
                      ? DefaultBatteryStatusType.charging
                      : batteryLevel < 20
                          ? DefaultBatteryStatusType.low
                          : DefaultBatteryStatusType.normal,
                ),
                trackHeight: widget.size,
                trackAspectRatio: 2.0,
                curve: Curves.ease,
                duration: widget.duration,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Icon(CupertinoIcons.exclamationmark_circle);
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }
}
