# Realtime Battery Indicator

[![GitHub stars](https://img.shields.io/github/stars/mantreshkhurana/realtime_battery_indicator.svg?style=social)](https://github.com/mantreshkhurana/realtime_battery_indicator)
[![pub package](https://img.shields.io/pub/v/realtime_battery_indicator.svg)](https://pub.dartlang.org/packages/realtime_battery_indicator)

A realtime good looking customizable battery indicator for all platforms.

![Screenshot](https://raw.githubusercontent.com/mantreshkhurana/realtime_battery_indicator/stable/screenshots/screenshot-1.png)

It can detect if the device is charging or not and can turn battery level to red colour if battery level is less than 20%. More customizations are coming soon.

<kbd>![Charging](https://raw.githubusercontent.com/mantreshkhurana/realtime_battery_indicator/stable/screenshots/charging.gif)</kbd>

## Installation

Add `realtime_battery_indicator: ^1.0.2` in your project's pubspec.yaml:

```yaml
dependencies:
  realtime_battery_indicator: ^1.0.2
```

## Usage

Import `realtime_battery_indicator` in your dart file:

```dart
import 'package:realtime_battery_indicator/realtime_battery_indicator.dart';
```

### Default Usage

```dart
BatteryIndicator();
```

### Custom Usage

```dart
BatteryIndicator(
  showBatteryLevel: true,
  size: 20.0,
  textStyle: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  ),
  duration: Duration(milliseconds: 200),
);
```

## Author

- [Mantresh Khurana](https://github.com/mantreshkhurana)
