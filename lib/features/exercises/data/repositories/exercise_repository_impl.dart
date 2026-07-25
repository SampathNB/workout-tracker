import 'package:gym_track/core/data/hive_crud_repository.dart';
import 'package:gym_track/features/exercises/data/datasources/exercise_local_data_source.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise_enums.dart';
import 'package:gym_track/features/exercises/domain/repositories/exercise_repository.dart';

/// Hive implementation of [ExerciseRepository].
class ExerciseRepositoryImpl extends HiveCrudRepository<Exercise>
    implements ExerciseRepository {
  const ExerciseRepositoryImpl(ExerciseLocalDataSource super.dataSource);

  @override
  String get entityName => 'Exercise';

  @override
  String idOf(Exercise item) => item.id;

  @override
  Exercise touch(Exercise item) => item.copyWith(updatedAt: DateTime.now());

  @override
  Future<List<Exercise>> getLibrary() =>
      guard(() => _sorted(_activeOf(dataSource.readAll())), 'load');

  @override
  Future<List<Exercise>> search(String query) => guard(() {
    final matches = _activeOf(
      dataSource.readAll(),
    ).where((exercise) => exercise.matches(query));
    return _sorted(matches);
  }, 'search');

  @override
  Future<List<Exercise>> getByMuscle(MuscleGroup muscle) => guard(() {
    final matches = _activeOf(
      dataSource.readAll(),
    ).where((exercise) => exercise.allMuscles.contains(muscle));
    return _sorted(matches);
  }, 'load');

  @override
  Future<List<Exercise>> getByEquipment(Equipment equipment) => guard(() {
    final matches = _activeOf(
      dataSource.readAll(),
    ).where((exercise) => exercise.equipment == equipment);
    return _sorted(matches);
  }, 'load');

  @override
  Future<List<Exercise>> getByCategory(ExerciseCategory category) => guard(() {
    final matches = _activeOf(
      dataSource.readAll(),
    ).where((exercise) => exercise.category == category);
    return _sorted(matches);
  }, 'load');

  @override
  Future<List<Exercise>> getByLibraryCategory(
    ExerciseLibraryCategory category,
  ) => guard(() {
    final matches = _activeOf(
      dataSource.readAll(),
    ).where((exercise) => exercise.libraryCategory == category);
    return _sorted(matches);
  }, 'load');

  @override
  Future<List<Exercise>> getFavorites() => guard(() {
    final matches = _activeOf(
      dataSource.readAll(),
    ).where((exercise) => exercise.isFavorite);
    return _sorted(matches);
  }, 'load');

  @override
  Future<List<Exercise>> getCustom() => guard(() {
    final matches = _activeOf(
      dataSource.readAll(),
    ).where((exercise) => exercise.isCustom);
    return _sorted(matches);
  }, 'load');

  @override
  Future<List<Exercise>> getDefaults() => guard(() {
    final matches = _activeOf(
      dataSource.readAll(),
    ).where((exercise) => !exercise.isCustom);
    return _sorted(matches);
  }, 'load');

  @override
  Future<Exercise> toggleFavorite(String id) async {
    final exercise = await requireById(id);
    return save(exercise.copyWith(isFavorite: !exercise.isFavorite));
  }

  @override
  Future<Exercise> archive(String id, {bool isArchived = true}) async {
    final exercise = await requireById(id);
    return save(exercise.copyWith(isArchived: isArchived));
  }

  @override
  Stream<List<Exercise>> watchLibrary() =>
      dataSource.watchAll().map((exercises) => _sorted(_activeOf(exercises)));

  Iterable<Exercise> _activeOf(Iterable<Exercise> exercises) =>
      exercises.where((exercise) => !exercise.isArchived);

  List<Exercise> _sorted(Iterable<Exercise> exercises) =>
      List<Exercise>.of(exercises)..sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
}
