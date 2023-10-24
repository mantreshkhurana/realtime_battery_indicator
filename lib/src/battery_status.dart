import 'battery_status_type.dart';
import 'index.dart';

class DefaultBatteryStatus {
  const DefaultBatteryStatus({
    required int value,
    DefaultBatteryStatusType type = DefaultBatteryStatusType.normal,
  })  : _value = value,
        _type = type;

  final int _value;
  int get value => type != DefaultBatteryStatusType.error ? _value : 100;

  final DefaultBatteryStatusType _type;
  DefaultBatteryStatusType get type {
    if (_type.isError || !(0 <= _value && _value <= 100)) {
      return DefaultBatteryStatusType.error;
    }
    return _type;
  }

  Color getBatteryColor(ColorScheme colorScheme) {
    if (type.isError) return Colors.red[900]!;
    if (type.isCharing) return Colors.green[500]!;
    if (type.isLow) return Colors.orange[700]!;
    return 0 <= _value && _value <= 20 ? Colors.red[500]! : Colors.green[500]!;
  }
}
