import 'battery_status.dart';
import 'index.dart';

/// A widget that displays the battery level and status.
class DefaultBatteryIndicator extends StatelessWidget {
  const DefaultBatteryIndicator({
    super.key,
    required this.status,
    this.trackHeight = 10.0,
    this.trackAspectRatio = 2.0,
    this.curve = Curves.ease,
    this.duration = const Duration(seconds: 1),
  }) : assert(trackAspectRatio >= 1, 'width:height must >= 1');

  /// The battery status.
  final DefaultBatteryStatus status;

  /// The height of the track.
  final double trackHeight;

  /// The width of the track.
  final double trackAspectRatio;

  /// The curve of the animation.
  final Curve curve;

  /// The duration of the animation.
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final track = _buildTrack(context, colorScheme);
    final knob = _buildKnob(context, colorScheme);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [track, knob],
    );
  }

  Widget _buildTrack(BuildContext context, ColorScheme colorScheme) {
    final borderRadius = BorderRadius.circular(trackHeight / 4);
    final borderColor = Theme.of(context).colorScheme.onSurface;

    final bar = _buildBar(context, trackHeight * 5 / 6, colorScheme);
    final icon = _buildIcon();

    final children = [bar, icon];

    return Container(
      height: trackHeight,
      width: trackHeight * trackAspectRatio,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: borderColor),
      ),
      child: Stack(
        children: children,
      ),
    );
  }

  Widget _buildBar(
    BuildContext context,
    double barHeight,
    ColorScheme colorScheme,
  ) {
    final barWidth = trackHeight * trackAspectRatio;
    final borderRadius = barHeight / 5;
    final currentColor = status.getBatteryColor(colorScheme);

    return Padding(
      padding: EdgeInsets.all(trackHeight / 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            const SizedBox.expand(),
            AnimatedContainer(
              duration: duration,
              width: barWidth * status.value / 100,
              height: double.infinity,
              curve: curve,
              decoration: BoxDecoration(
                color: currentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: duration.inMilliseconds ~/ 5),
            switchInCurve: curve,
            switchOutCurve: curve,
            child: status.type.isCharing
                ? Icon(
                    Icons.electric_bolt,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: constraints.maxHeight,
                    shadows: [
                      const Shadow(blurRadius: 0.5),
                      Shadow(
                        color: Theme.of(context).colorScheme.onSurface,
                        blurRadius: 1,
                      ),
                    ],
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildKnob(BuildContext context, ColorScheme colorScheme) {
    final double knobHeight = trackHeight / 3;
    final double knobWidth = knobHeight / 2;
    final borderColor = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: EdgeInsets.only(left: trackHeight / 20),
      child: Container(
        width: knobWidth,
        height: knobHeight,
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(knobWidth / 3),
          ),
        ),
      ),
    );
  }
}
