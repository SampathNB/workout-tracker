import 'package:gym_track/core/domain/crud_repository.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise_enums.dart';

/// Persistence contract for the exercise library.
abstract interface class ExerciseRepository implements CrudRepository<Exercise> {
  /// Non-archived exercises sorted alphabetically.
  Future<List<Exercise>> getLibrary();

  /// Name/muscle/equipment search over the library.
  Future<List<Exercise>> search(String query);

  Future<List<Exercise>> getByMuscle(MuscleGroup muscle);

  Future<List<Exercise>> getByEquipment(Equipment equipment);

  Future<List<Exercise>> getByCategory(ExerciseCategory category);

  Future<List<Exercise>> getFavorites();

  /// User-created exercises.
  Future<List<Exercise>> getCustom();

  /// Flips the favorite flag and returns the updated exercise.
  Future<Exercise> toggleFavorite(String id);

  /// Soft-deletes an exercise so historical sessions keep resolving it.
  Future<Exercise> archive(String id, {bool isArchived = true});

  /// Library snapshot, re-emitted on every write.
  Stream<List<Exercise>> watchLibrary();
}
