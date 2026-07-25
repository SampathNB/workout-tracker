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

Business logic is intentionally not implemented yet; screens are placeholders
with working navigation and theme switching.
