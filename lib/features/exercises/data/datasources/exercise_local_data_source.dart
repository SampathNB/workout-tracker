import 'package:gym_track/core/storage/hive_box_data_source.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise.dart';

/// Hive-backed storage for the exercise library.
class ExerciseLocalDataSource extends HiveBoxDataSource<Exercise> {
  const ExerciseLocalDataSource(super.box);

  @override
  String keyOf(Exercise item) => item.id;

  /// Exercises kept by the user (library entries are not archived).
  List<Exercise> readActive() =>
      box.values.where((exercise) => !exercise.isArchived).toList();
}
