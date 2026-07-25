/// Lifecycle of a [WorkoutSession].
enum WorkoutStatus { planned, inProgress, completed, skipped }

/// Nature of a logged set.
enum SetType { warmUp, normal, dropSet, failure, amrap, cooldown }

/// Relative intensity of a [WorkoutPlan].
enum PlanDifficulty { beginner, intermediate, advanced }
