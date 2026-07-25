/// What a goal measures.
enum GoalType {
  bodyWeight,
  bodyFat,
  strength,
  endurance,
  consistency,
  custom,
}

/// Lifecycle of a goal.
enum GoalStatus { active, achieved, missed, archived }

/// Standard progress-photo angles.
enum PhotoPose { front, side, back, other }

/// Direction a goal metric should move.
enum GoalDirection { increase, decrease }
