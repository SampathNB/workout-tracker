import 'package:gym_track/features/progress/domain/entities/progress_enums.dart';

/// A physique photo stored on device and referenced by file path.
class ProgressPhoto {
  const ProgressPhoto({
    required this.id,
    required this.filePath,
    required this.takenAt,
    this.pose = PhotoPose.front,
    this.thumbnailPath,
    this.weightKg,
    this.weightEntryId,
    this.note,
    this.isFavorite = false,
    this.createdAt,
  });

  final String id;

  /// Absolute path inside the app documents directory.
  final String filePath;
  final DateTime takenAt;
  final PhotoPose pose;
  final String? thumbnailPath;

  /// Body weight at capture time, for side-by-side comparisons.
  final double? weightKg;

  /// Optional link to the [WeightEntry] logged the same day.
  final String? weightEntryId;
  final String? note;
  final bool isFavorite;
  final DateTime? createdAt;

  ProgressPhoto copyWith({
    String? filePath,
    DateTime? takenAt,
    PhotoPose? pose,
    String? thumbnailPath,
    double? weightKg,
    String? weightEntryId,
    String? note,
    bool? isFavorite,
  }) {
    return ProgressPhoto(
      id: id,
      filePath: filePath ?? this.filePath,
      takenAt: takenAt ?? this.takenAt,
      pose: pose ?? this.pose,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      weightKg: weightKg ?? this.weightKg,
      weightEntryId: weightEntryId ?? this.weightEntryId,
      note: note ?? this.note,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt,
    );
  }
}

extension ProgressPhotoX on ProgressPhoto {
  /// Calendar day of capture, normalized to midnight local time.
  DateTime get day => DateTime(takenAt.year, takenAt.month, takenAt.day);

  /// Path used for grid previews, falling back to the full-size image.
  String get previewPath => thumbnailPath ?? filePath;
}
