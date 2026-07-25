import 'dart:async';

import 'package:gym_track/core/domain/crud_repository.dart';
import 'package:gym_track/core/error/exceptions.dart';
import 'package:gym_track/core/storage/hive_box_data_source.dart';

/// Hive-backed implementation of [CrudRepository].
///
/// Concrete repositories extend this, pass their datasource and add
/// domain-specific queries. Every storage call is funnelled through [guard] so
/// low-level Hive errors surface as [CacheException].
abstract class HiveCrudRepository<T> implements CrudRepository<T> {
  const HiveCrudRepository(this.dataSource);

  final HiveBoxDataSource<T> dataSource;

  /// Entity id used as the Hive key.
  String idOf(T item) => dataSource.keyOf(item);

  /// Hook for stamping `updatedAt` (or similar) before a write.
  ///
  /// Defaults to returning [item] unchanged.
  T touch(T item) => item;

  /// Human-readable entity name used in error messages.
  String get entityName => T.toString();

  /// Runs [action], translating unexpected errors into [CacheException].
  Future<R> guard<R>(FutureOr<R> Function() action, String operation) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        CacheException('Failed to $operation $entityName: $error'),
        stackTrace,
      );
    }
  }

  @override
  Future<List<T>> getAll() => guard(dataSource.readAll, 'load');

  @override
  Future<T?> getById(String id) => guard(() => dataSource.read(id), 'load');

  /// Like [getById] but throws [NotFoundException] instead of returning null.
  Future<T> requireById(String id) async {
    final item = await getById(id);
    if (item == null) {
      throw NotFoundException('$entityName "$id" was not found');
    }
    return item;
  }

  @override
  Future<T> create(T item) async {
    final id = idOf(item);
    return guard(() async {
      if (dataSource.contains(id)) {
        throw DuplicateRecordException('$entityName "$id" already exists');
      }
      final stamped = touch(item);
      await dataSource.write(stamped);
      return stamped;
    }, 'create');
  }

  @override
  Future<T> update(T item) async {
    final id = idOf(item);
    return guard(() async {
      if (!dataSource.contains(id)) {
        throw NotFoundException('$entityName "$id" was not found');
      }
      final stamped = touch(item);
      await dataSource.write(stamped);
      return stamped;
    }, 'update');
  }

  @override
  Future<T> save(T item) => guard(() async {
    final stamped = touch(item);
    await dataSource.write(stamped);
    return stamped;
  }, 'save');

  @override
  Future<void> saveAll(Iterable<T> items) => guard(
    () => dataSource.writeAll(items.map(touch)),
    'save multiple',
  );

  @override
  Future<void> delete(String id) => guard(() => dataSource.remove(id), 'delete');

  @override
  Future<void> deleteAll(Iterable<String> ids) =>
      guard(() => dataSource.removeAll(ids), 'delete multiple');

  @override
  Future<void> clear() => guard(dataSource.clear, 'clear');

  @override
  Future<bool> exists(String id) =>
      guard(() => dataSource.contains(id), 'look up');

  @override
  Future<int> count() => guard(() => dataSource.count, 'count');

  @override
  Stream<List<T>> watchAll() => dataSource.watchAll();

  @override
  Stream<T?> watchById(String id) => dataSource.watchById(id);
}
