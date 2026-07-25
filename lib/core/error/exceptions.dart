/// Data-layer exception types.
class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => 'AppException: $message';
}

/// Local storage (Hive) read/write failure.
class CacheException extends AppException {
  const CacheException([super.message = 'Cache exception']);

  @override
  String toString() => 'CacheException: $message';
}

/// A record was expected in storage but is missing.
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Record not found']);

  @override
  String toString() => 'NotFoundException: $message';
}

/// A record with the same identifier already exists.
class DuplicateRecordException extends AppException {
  const DuplicateRecordException([super.message = 'Record already exists']);

  @override
  String toString() => 'DuplicateRecordException: $message';
}

class ServerException extends AppException {
  const ServerException([super.message = 'Server exception']);

  @override
  String toString() => 'ServerException: $message';
}
