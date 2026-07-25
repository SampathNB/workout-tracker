# GymTrack

Production-ready Flutter workout tracker scaffolded with Clean Architecture
(feature-first), Material 3, Riverpod, GoRouter, Hive CE, and flutter_hooks.

## Stack

| Concern | Package |
|---|---|
| State / DI | `hooks_riverpod` + `flutter_riverpod` |
| Navigation | `go_router` (StatefulShellRoute) |
| Local storage | `hive_ce` / `hive_ce_flutter` |
| Hooks | `flutter_hooks` |
| Theming | Material 3 + Google Fonts (Outfit / DM Sans) |
| Lints | `flutter_lints` with strict analyzer options |

## Getting started

```bash
flutter pub get
flutter run
```

```bash
flutter analyze
flutter test
```

## Shell navigation

Animated bottom bar tabs (state preserved via `StatefulShellRoute`):

**Dashboard · Calendar · Workout · Progress · Settings**

```
lib/
  main.dart                 # Bootstrap + ProviderScope overrides
  app/
    app.dart                # MaterialApp.router
    router/                 # GoRouter + route names
    theme/                  # Light/dark Material 3 themes
  core/
    constants/              # App + breakpoint constants
    di/                     # Dependency injection providers
    error/                  # Failure / exception scaffolding
    storage/                # Hive CE initialization
    utils/                  # Responsive helpers
    widgets/                # Shell, animated nav, layout, placeholders
  features/
    splash/
    home/                   # Dashboard
    calendar/
    workouts/
    exercises/
    progress/
    settings/
```

Each feature follows Clean Architecture layers:

- `domain/` — entities, repository contracts, use cases
- `data/` — models, datasources, repository implementations
- `presentation/` — screens, widgets, Riverpod providers

Screens are still placeholders; the persistence layer below is implemented.

## Persistence

Hive CE stores one box per aggregate. Adapters are generated from
`lib/hive/hive_adapters.dart` via `@GenerateAdapters`, so domain entities stay
free of persistence annotations. Type ids and field indices are tracked in
`lib/hive/hive_adapters.g.yaml` — **check it into version control** and
regenerate after changing any entity:

```bash
dart run build_runner build
```

| Box | Entity |
|---|---|
| `settings` | `AppSettings` (single record) |
| `exercises` | `Exercise` |
| `workout_sessions` | `WorkoutSession` → `SessionExercise` → `ExerciseSet` |
| `workout_plans` | `WorkoutPlan` → `PlanExercise` |
| `weight_entries` | `WeightEntry` |
| `progress_photos` | `ProgressPhoto` (paths only; files live on disk) |
| `goals` | `Goal` |

`HiveStorage.init()` registers adapters and opens every typed box during
bootstrap. Pass `path:` to run against a temp directory in tests.

### Repository pattern

`CrudRepository<T>` (`lib/core/domain/`) defines the shared contract —
`getAll`, `getById`, `create`, `update`, `save`, `saveAll`, `delete`,
`deleteAll`, `clear`, `exists`, `count`, `watchAll`, `watchById`.

`HiveCrudRepository<T>` (`lib/core/data/`) implements it on top of
`HiveBoxDataSource<T>` and translates storage errors into `CacheException`,
`NotFoundException` and `DuplicateRecordException`. Feature repositories extend
it and add domain queries (sessions by day, scheduled plans, weight trends,
goal progress, …). Settings use `SettingsRepository`, a single-record variant.

Inject repositories through the providers in `lib/core/di/injection.dart`:

```dart
final sessions = ref.watch(workoutSessionRepositoryProvider);
final today = await sessions.getForDay(DateTime.now());
```
