import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_track/core/di/injection.dart';
import 'package:gym_track/features/home/domain/dashboard_assembler.dart';
import 'package:gym_track/features/home/domain/entities/dashboard_snapshot.dart';

/// Live dashboard view-model. Invalidated by pull-to-refresh and rebuilds
/// when any watched repository provider changes identity (rare).
final dashboardSnapshotProvider =
    FutureProvider.autoDispose<DashboardSnapshot>((ref) {
  return DashboardAssembler.assemble(
    sessions: ref.watch(workoutSessionRepositoryProvider),
    plans: ref.watch(workoutPlanRepositoryProvider),
    weights: ref.watch(weightEntryRepositoryProvider),
    goals: ref.watch(goalRepositoryProvider),
    settingsRepo: ref.watch(settingsRepositoryProvider),
  );
});
