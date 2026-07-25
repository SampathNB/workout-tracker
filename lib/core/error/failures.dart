/// Domain-layer failure types (no business logic yet — scaffolding only).
sealed class Failure {
  const Failure(this.message);

  final String message;
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error']);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error']);
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Unexpected error']);
}
