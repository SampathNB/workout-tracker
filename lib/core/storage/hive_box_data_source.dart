import 'package:hive_ce/hive_ce.dart';

/// Thin, synchronous wrapper around a Hive [Box] keyed by entity id.
///
/// Feature datasources extend this and implement [keyOf]; repositories add
/// error handling, ordering and domain-specific queries on top.
abstract class HiveBoxDataSource<T> {
  const HiveBoxDataSource(this.box);

  final Box<T> box;

  /// Extracts the storage key (entity id) from [item].
  String keyOf(T item);

  List<T> readAll() => box.values.toList(growable: false);

  T? read(String id) => box.get(id);

  bool contains(String id) => box.containsKey(id);

  int get count => box.length;

  bool get isEmpty => box.isEmpty;

  Iterable<String> get keys => box.keys.cast<String>();

  Future<void> write(T item) => box.put(keyOf(item), item);

  Future<void> writeAll(Iterable<T> items) =>
      box.putAll(<String, T>{for (final item in items) keyOf(item): item});

  Future<void> remove(String id) => box.delete(id);

  Future<void> removeAll(Iterable<String> ids) => box.deleteAll(ids);

  Future<int> clear() => box.clear();

  Future<void> flush() => box.flush();

  /// Raw box events, optionally scoped to a single key.
  Stream<BoxEvent> events({String? id}) => box.watch(key: id);

  /// Current snapshot followed by a new snapshot after every write.
  Stream<List<T>> watchAll() async* {
    yield readAll();
    yield* box.watch().map((_) => readAll());
  }

  /// Current value of [id] followed by its value after every write to it.
  Stream<T?> watchById(String id) async* {
    yield read(id);
    yield* box.watch(key: id).map((_) => read(id));
  }
}
