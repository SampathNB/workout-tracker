import 'dart:math';

/// Generates sortable, collision-resistant identifiers without extra
/// dependencies.
///
/// Format: `<base36 millisecond timestamp>-<base36 random suffix>`, e.g.
/// `m1x4k2p9-4f7a1c`. The timestamp prefix keeps ids lexicographically
/// sortable by creation time, which is handy for Hive keys.
abstract final class IdGenerator {
  static final Random _random = Random.secure();

  /// Returns a new unique id.
  static String generate() {
    final timestamp = DateTime.now()
        .toUtc()
        .millisecondsSinceEpoch
        .toRadixString(36);
    final suffix = List<String>.generate(
      6,
      (_) => _random.nextInt(36).toRadixString(36),
    ).join();
    return '$timestamp-$suffix';
  }
}
