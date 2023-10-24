enum DefaultBatteryStatusType {
  error,
  low,
  charging,
  normal;

  bool get isError => this == DefaultBatteryStatusType.error;
  bool get isLow => this == DefaultBatteryStatusType.low;
  bool get isCharing => this == DefaultBatteryStatusType.charging;
  bool get isNormal => this == DefaultBatteryStatusType.normal;
}
