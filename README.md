# Realtime Battery Indicator

[![GitHub stars](https://img.shields.io/github/stars/mantreshkhurana/realtime_battery_indicator.svg?style=social)](https://github.com/mantreshkhurana/realtime_battery_indicator)
[![pub package](https://img.shields.io/pub/v/realtime_battery_indicator.svg)](https://pub.dartlang.org/packages/realtime_battery_indicator)

A realtime good looking customizable battery indicator for all platforms.

![Screenshot](https://raw.githubusercontent.com/mantreshkhurana/realtime_battery_indicator/stable/screenshots/screenshot-1.png)

## Installation

Add `realtime_battery_indicator: ^1.0.0` in your project's pubspec.yaml:

```yaml
dependencies:
  realtime_battery_indicator: ^1.0.0
```

## Usage

Import `realtime_battery_indicator` in your dart file:

```dart
import 'package:realtime_battery_indicator/realtime_battery_indicator.dart';
```

Then use `checkAppUpdate` in your code:

> checkAppUpdate function won't show any dialog in iOS Simulator. [Source](https://stackoverflow.com/questions/13645554/itunes-app-link-cannot-open-page-in-safari-in-simulator-and-also-idevices)

### Default Usage

```dart
BatteryIndicator();
```

### Custom Usage

To hide battery level, use `showBatteryLevel`:

```dart
BatteryIndicator(
    showBatteryLevel: false;
);
```

## Author

- [Mantresh Khurana](https://github.com/mantreshkhurana)
