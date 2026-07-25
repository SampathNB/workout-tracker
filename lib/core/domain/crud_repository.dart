/// Storage-agnostic CRUD contract shared by every entity repository.
///
/// Implementations throw [AppException] subtypes on failure:
/// [NotFoundException] when updating a missing record,
/// [DuplicateRecordException] when creating an existing one and
/// [CacheException] for any underlying storage error.
abstract interface class CrudRepository<T> {
  /// All records, unsorted.
  Future<List<T>> getAll();

  /// The record with [id], or null when absent.
  Future<T?> getById(String id);

  /// Inserts a new record. Throws if [id] already exists.
  Future<T> create(T item);

  /// Replaces an existing record. Throws if it does not exist.
  Future<T> update(T item);

  /// Inserts or replaces a record.
  Future<T> save(T item);

  /// Inserts or replaces many records in one write.
  Future<void> saveAll(Iterable<T> items);

  /// Removes the record with [id]; no-op when absent.
  Future<void> delete(String id);

  /// Removes many records in one write.
  Future<void> deleteAll(Iterable<String> ids);

  /// Removes every record.
  Future<void> clear();

  Future<bool> exists(String id);

  Future<int> count();

  /// Emits the full collection immediately and after every write.
  Stream<List<T>> watchAll();

  /// Emits the record with [id] immediately and after every write to it.
  Stream<T?> watchById(String id);
}
