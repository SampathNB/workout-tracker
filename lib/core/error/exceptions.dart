/// Data-layer exception types (no business logic yet — scaffolding only).
class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => 'AppException: $message';
}

class CacheException extends AppException {
  const CacheException([super.message = 'Cache exception']);
}

class ServerException extends AppException {
  const ServerException([super.message = 'Server exception']);
}
