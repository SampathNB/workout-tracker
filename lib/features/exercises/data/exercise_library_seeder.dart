import 'package:gym_track/features/exercises/data/default_exercise_library.dart';
import 'package:gym_track/features/exercises/domain/repositories/exercise_repository.dart';

/// Idempotently loads [DefaultExerciseLibrary] into local storage.
///
/// Missing bundled exercises are inserted; existing rows (including user
/// favorites / archives on the same id) are left untouched so upgrades can
/// ship new defaults without wiping customizations.
abstract final class ExerciseLibrarySeeder {
  /// Ensures every bundled exercise exists. Returns how many were inserted.
  static Future<int> ensureSeeded(ExerciseRepository repository) async {
    var inserted = 0;
    for (final exercise in DefaultExerciseLibrary.all) {
      if (await repository.exists(exercise.id)) continue;
      await repository.create(exercise);
      inserted += 1;
    }
    return inserted;
  }
}
