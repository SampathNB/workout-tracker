/// A body-weight measurement logged by the user.
///
/// Weight is always stored in kilograms; presentation converts to the unit
/// system configured in settings.
class WeightEntry {
  const WeightEntry({
    required this.id,
    required this.weightKg,
    required this.recordedAt,
    this.bodyFatPercentage,
    this.muscleMassKg,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final double weightKg;

  /// Moment the measurement was taken.
  final DateTime recordedAt;
  final double? bodyFatPercentage;
  final double? muscleMassKg;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  WeightEntry copyWith({
    double? weightKg,
    DateTime? recordedAt,
    double? bodyFatPercentage,
    double? muscleMassKg,
    String? note,
    DateTime? updatedAt,
  }) {
    return WeightEntry(
      id: id,
      weightKg: weightKg ?? this.weightKg,
      recordedAt: recordedAt ?? this.recordedAt,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      muscleMassKg: muscleMassKg ?? this.muscleMassKg,
      note: note ?? this.note,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

extension WeightEntryX on WeightEntry {
  /// Calendar day of the measurement, normalized to midnight local time.
  DateTime get day =>
      DateTime(recordedAt.year, recordedAt.month, recordedAt.day);

  double get weightLb => weightKg * 2.2046226218;

  /// Body mass index for a given height, or null when height is unknown.
  double? bmiForHeightCm(double? heightCm) {
    if (heightCm == null || heightCm <= 0) return null;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }
}
