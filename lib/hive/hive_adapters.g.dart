// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final typeId = 0;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      id: fields[0] as String,
      name: fields[1] as String,
      primaryMuscle: fields[2] as MuscleGroup,
      createdAt: fields[14] as DateTime,
      libraryCategory: fields[16] == null
          ? ExerciseLibraryCategory.chest
          : fields[16] as ExerciseLibraryCategory,
      secondaryMuscles: fields[3] == null
          ? const <MuscleGroup>[]
          : (fields[3] as List).cast<MuscleGroup>(),
      equipment: fields[4] == null
          ? Equipment.bodyweight
          : fields[4] as Equipment,
      category: fields[5] == null
          ? ExerciseCategory.strength
          : fields[5] as ExerciseCategory,
      tracking: fields[6] == null
          ? ExerciseTracking.weightAndReps
          : fields[6] as ExerciseTracking,
      instructions: fields[7] as String?,
      imagePath: fields[8] as String?,
      videoUrl: fields[9] as String?,
      recommendedSets: fields[17] == null ? 3 : (fields[17] as num).toInt(),
      recommendedRepsMin: fields[18] == null ? 8 : (fields[18] as num).toInt(),
      recommendedRepsMax: fields[19] == null
          ? 12
          : (fields[19] as num?)?.toInt(),
      recommendedDurationSeconds: (fields[20] as num?)?.toInt(),
      recommendedDurationMaxSeconds: (fields[21] as num?)?.toInt(),
      defaultRestSeconds: fields[10] == null ? 90 : (fields[10] as num).toInt(),
      isCustom: fields[11] == null ? false : fields[11] as bool,
      isFavorite: fields[12] == null ? false : fields[12] as bool,
      isArchived: fields[13] == null ? false : fields[13] as bool,
      updatedAt: fields[15] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.primaryMuscle)
      ..writeByte(3)
      ..write(obj.secondaryMuscles)
      ..writeByte(4)
      ..write(obj.equipment)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.tracking)
      ..writeByte(7)
      ..write(obj.instructions)
      ..writeByte(8)
      ..write(obj.imagePath)
      ..writeByte(9)
      ..write(obj.videoUrl)
      ..writeByte(10)
      ..write(obj.defaultRestSeconds)
      ..writeByte(11)
      ..write(obj.isCustom)
      ..writeByte(12)
      ..write(obj.isFavorite)
      ..writeByte(13)
      ..write(obj.isArchived)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt)
      ..writeByte(16)
      ..write(obj.libraryCategory)
      ..writeByte(17)
      ..write(obj.recommendedSets)
      ..writeByte(18)
      ..write(obj.recommendedRepsMin)
      ..writeByte(19)
      ..write(obj.recommendedRepsMax)
      ..writeByte(20)
      ..write(obj.recommendedDurationSeconds)
      ..writeByte(21)
      ..write(obj.recommendedDurationMaxSeconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MuscleGroupAdapter extends TypeAdapter<MuscleGroup> {
  @override
  final typeId = 1;

  @override
  MuscleGroup read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MuscleGroup.chest;
      case 1:
        return MuscleGroup.upperBack;
      case 2:
        return MuscleGroup.lats;
      case 3:
        return MuscleGroup.shoulders;
      case 4:
        return MuscleGroup.biceps;
      case 5:
        return MuscleGroup.triceps;
      case 6:
        return MuscleGroup.forearms;
      case 7:
        return MuscleGroup.core;
      case 8:
        return MuscleGroup.glutes;
      case 9:
        return MuscleGroup.quadriceps;
      case 10:
        return MuscleGroup.hamstrings;
      case 11:
        return MuscleGroup.calves;
      case 12:
        return MuscleGroup.fullBody;
      case 13:
        return MuscleGroup.cardio;
      default:
        return MuscleGroup.chest;
    }
  }

  @override
  void write(BinaryWriter writer, MuscleGroup obj) {
    switch (obj) {
      case MuscleGroup.chest:
        writer.writeByte(0);
      case MuscleGroup.upperBack:
        writer.writeByte(1);
      case MuscleGroup.lats:
        writer.writeByte(2);
      case MuscleGroup.shoulders:
        writer.writeByte(3);
      case MuscleGroup.biceps:
        writer.writeByte(4);
      case MuscleGroup.triceps:
        writer.writeByte(5);
      case MuscleGroup.forearms:
        writer.writeByte(6);
      case MuscleGroup.core:
        writer.writeByte(7);
      case MuscleGroup.glutes:
        writer.writeByte(8);
      case MuscleGroup.quadriceps:
        writer.writeByte(9);
      case MuscleGroup.hamstrings:
        writer.writeByte(10);
      case MuscleGroup.calves:
        writer.writeByte(11);
      case MuscleGroup.fullBody:
        writer.writeByte(12);
      case MuscleGroup.cardio:
        writer.writeByte(13);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MuscleGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EquipmentAdapter extends TypeAdapter<Equipment> {
  @override
  final typeId = 2;

  @override
  Equipment read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Equipment.bodyweight;
      case 1:
        return Equipment.barbell;
      case 2:
        return Equipment.dumbbell;
      case 3:
        return Equipment.kettlebell;
      case 4:
        return Equipment.machine;
      case 5:
        return Equipment.cable;
      case 6:
        return Equipment.smithMachine;
      case 7:
        return Equipment.resistanceBand;
      case 8:
        return Equipment.medicineBall;
      case 9:
        return Equipment.pullUpBar;
      case 10:
        return Equipment.bench;
      case 11:
        return Equipment.cardioMachine;
      case 12:
        return Equipment.other;
      default:
        return Equipment.bodyweight;
    }
  }

  @override
  void write(BinaryWriter writer, Equipment obj) {
    switch (obj) {
      case Equipment.bodyweight:
        writer.writeByte(0);
      case Equipment.barbell:
        writer.writeByte(1);
      case Equipment.dumbbell:
        writer.writeByte(2);
      case Equipment.kettlebell:
        writer.writeByte(3);
      case Equipment.machine:
        writer.writeByte(4);
      case Equipment.cable:
        writer.writeByte(5);
      case Equipment.smithMachine:
        writer.writeByte(6);
      case Equipment.resistanceBand:
        writer.writeByte(7);
      case Equipment.medicineBall:
        writer.writeByte(8);
      case Equipment.pullUpBar:
        writer.writeByte(9);
      case Equipment.bench:
        writer.writeByte(10);
      case Equipment.cardioMachine:
        writer.writeByte(11);
      case Equipment.other:
        writer.writeByte(12);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseCategoryAdapter extends TypeAdapter<ExerciseCategory> {
  @override
  final typeId = 3;

  @override
  ExerciseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExerciseCategory.strength;
      case 1:
        return ExerciseCategory.hypertrophy;
      case 2:
        return ExerciseCategory.cardio;
      case 3:
        return ExerciseCategory.mobility;
      case 4:
        return ExerciseCategory.plyometric;
      case 5:
        return ExerciseCategory.olympic;
      case 6:
        return ExerciseCategory.stretching;
      default:
        return ExerciseCategory.strength;
    }
  }

  @override
  void write(BinaryWriter writer, ExerciseCategory obj) {
    switch (obj) {
      case ExerciseCategory.strength:
        writer.writeByte(0);
      case ExerciseCategory.hypertrophy:
        writer.writeByte(1);
      case ExerciseCategory.cardio:
        writer.writeByte(2);
      case ExerciseCategory.mobility:
        writer.writeByte(3);
      case ExerciseCategory.plyometric:
        writer.writeByte(4);
      case ExerciseCategory.olympic:
        writer.writeByte(5);
      case ExerciseCategory.stretching:
        writer.writeByte(6);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseTrackingAdapter extends TypeAdapter<ExerciseTracking> {
  @override
  final typeId = 4;

  @override
  ExerciseTracking read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExerciseTracking.weightAndReps;
      case 1:
        return ExerciseTracking.repsOnly;
      case 2:
        return ExerciseTracking.duration;
      case 3:
        return ExerciseTracking.distanceAndDuration;
      default:
        return ExerciseTracking.weightAndReps;
    }
  }

  @override
  void write(BinaryWriter writer, ExerciseTracking obj) {
    switch (obj) {
      case ExerciseTracking.weightAndReps:
        writer.writeByte(0);
      case ExerciseTracking.repsOnly:
        writer.writeByte(1);
      case ExerciseTracking.duration:
        writer.writeByte(2);
      case ExerciseTracking.distanceAndDuration:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseTrackingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutSessionAdapter extends TypeAdapter<WorkoutSession> {
  @override
  final typeId = 5;

  @override
  WorkoutSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutSession(
      id: fields[0] as String,
      name: fields[1] as String,
      startedAt: fields[2] as DateTime,
      status: fields[3] == null
          ? WorkoutStatus.planned
          : fields[3] as WorkoutStatus,
      planId: fields[4] as String?,
      exercises: fields[5] == null
          ? const <SessionExercise>[]
          : (fields[5] as List).cast<SessionExercise>(),
      completedAt: fields[6] as DateTime?,
      durationSeconds: (fields[7] as num?)?.toInt(),
      perceivedExertion: (fields[8] as num?)?.toInt(),
      caloriesBurned: (fields[9] as num?)?.toInt(),
      bodyWeightKg: (fields[10] as num?)?.toDouble(),
      note: fields[11] as String?,
      updatedAt: fields[12] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutSession obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.startedAt)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.planId)
      ..writeByte(5)
      ..write(obj.exercises)
      ..writeByte(6)
      ..write(obj.completedAt)
      ..writeByte(7)
      ..write(obj.durationSeconds)
      ..writeByte(8)
      ..write(obj.perceivedExertion)
      ..writeByte(9)
      ..write(obj.caloriesBurned)
      ..writeByte(10)
      ..write(obj.bodyWeightKg)
      ..writeByte(11)
      ..write(obj.note)
      ..writeByte(12)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SessionExerciseAdapter extends TypeAdapter<SessionExercise> {
  @override
  final typeId = 6;

  @override
  SessionExercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionExercise(
      id: fields[0] as String,
      exerciseId: fields[1] as String,
      exerciseName: fields[2] as String,
      order: (fields[3] as num).toInt(),
      sets: fields[4] == null
          ? const <ExerciseSet>[]
          : (fields[4] as List).cast<ExerciseSet>(),
      restSeconds: (fields[5] as num?)?.toInt(),
      supersetGroup: (fields[6] as num?)?.toInt(),
      note: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SessionExercise obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.exerciseId)
      ..writeByte(2)
      ..write(obj.exerciseName)
      ..writeByte(3)
      ..write(obj.order)
      ..writeByte(4)
      ..write(obj.sets)
      ..writeByte(5)
      ..write(obj.restSeconds)
      ..writeByte(6)
      ..write(obj.supersetGroup)
      ..writeByte(7)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseSetAdapter extends TypeAdapter<ExerciseSet> {
  @override
  final typeId = 7;

  @override
  ExerciseSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseSet(
      id: fields[0] as String,
      setNumber: (fields[1] as num).toInt(),
      type: fields[2] == null ? SetType.normal : fields[2] as SetType,
      reps: fields[3] == null ? 0 : (fields[3] as num).toInt(),
      weightKg: fields[4] == null ? 0 : (fields[4] as num).toDouble(),
      durationSeconds: (fields[5] as num?)?.toInt(),
      distanceMeters: (fields[6] as num?)?.toDouble(),
      restSeconds: (fields[7] as num?)?.toInt(),
      rpe: (fields[8] as num?)?.toDouble(),
      isCompleted: fields[9] == null ? false : fields[9] as bool,
      completedAt: fields[10] as DateTime?,
      note: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseSet obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.setNumber)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.reps)
      ..writeByte(4)
      ..write(obj.weightKg)
      ..writeByte(5)
      ..write(obj.durationSeconds)
      ..writeByte(6)
      ..write(obj.distanceMeters)
      ..writeByte(7)
      ..write(obj.restSeconds)
      ..writeByte(8)
      ..write(obj.rpe)
      ..writeByte(9)
      ..write(obj.isCompleted)
      ..writeByte(10)
      ..write(obj.completedAt)
      ..writeByte(11)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutPlanAdapter extends TypeAdapter<WorkoutPlan> {
  @override
  final typeId = 8;

  @override
  WorkoutPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutPlan(
      id: fields[0] as String,
      name: fields[1] as String,
      createdAt: fields[12] as DateTime,
      description: fields[2] as String?,
      difficulty: fields[3] == null
          ? PlanDifficulty.beginner
          : fields[3] as PlanDifficulty,
      exercises: fields[4] == null
          ? const <PlanExercise>[]
          : (fields[4] as List).cast<PlanExercise>(),
      scheduledWeekdays: fields[5] == null
          ? const <int>[]
          : (fields[5] as List).cast<int>(),
      estimatedDurationMinutes: (fields[6] as num?)?.toInt(),
      tags: fields[7] == null
          ? const <String>[]
          : (fields[7] as List).cast<String>(),
      colorHex: fields[8] as String?,
      isActive: fields[9] == null ? true : fields[9] as bool,
      isArchived: fields[10] == null ? false : fields[10] as bool,
      lastPerformedAt: fields[11] as DateTime?,
      updatedAt: fields[13] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutPlan obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.difficulty)
      ..writeByte(4)
      ..write(obj.exercises)
      ..writeByte(5)
      ..write(obj.scheduledWeekdays)
      ..writeByte(6)
      ..write(obj.estimatedDurationMinutes)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.colorHex)
      ..writeByte(9)
      ..write(obj.isActive)
      ..writeByte(10)
      ..write(obj.isArchived)
      ..writeByte(11)
      ..write(obj.lastPerformedAt)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlanExerciseAdapter extends TypeAdapter<PlanExercise> {
  @override
  final typeId = 9;

  @override
  PlanExercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanExercise(
      id: fields[0] as String,
      exerciseId: fields[1] as String,
      exerciseName: fields[2] as String,
      order: (fields[3] as num).toInt(),
      targetSets: fields[4] == null ? 3 : (fields[4] as num).toInt(),
      targetRepsMin: fields[5] == null ? 8 : (fields[5] as num).toInt(),
      targetRepsMax: (fields[6] as num?)?.toInt(),
      targetWeightKg: (fields[7] as num?)?.toDouble(),
      targetDurationSeconds: (fields[8] as num?)?.toInt(),
      restSeconds: fields[9] == null ? 90 : (fields[9] as num).toInt(),
      supersetGroup: (fields[10] as num?)?.toInt(),
      note: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlanExercise obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.exerciseId)
      ..writeByte(2)
      ..write(obj.exerciseName)
      ..writeByte(3)
      ..write(obj.order)
      ..writeByte(4)
      ..write(obj.targetSets)
      ..writeByte(5)
      ..write(obj.targetRepsMin)
      ..writeByte(6)
      ..write(obj.targetRepsMax)
      ..writeByte(7)
      ..write(obj.targetWeightKg)
      ..writeByte(8)
      ..write(obj.targetDurationSeconds)
      ..writeByte(9)
      ..write(obj.restSeconds)
      ..writeByte(10)
      ..write(obj.supersetGroup)
      ..writeByte(11)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutStatusAdapter extends TypeAdapter<WorkoutStatus> {
  @override
  final typeId = 10;

  @override
  WorkoutStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WorkoutStatus.planned;
      case 1:
        return WorkoutStatus.inProgress;
      case 2:
        return WorkoutStatus.completed;
      case 3:
        return WorkoutStatus.skipped;
      default:
        return WorkoutStatus.planned;
    }
  }

  @override
  void write(BinaryWriter writer, WorkoutStatus obj) {
    switch (obj) {
      case WorkoutStatus.planned:
        writer.writeByte(0);
      case WorkoutStatus.inProgress:
        writer.writeByte(1);
      case WorkoutStatus.completed:
        writer.writeByte(2);
      case WorkoutStatus.skipped:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SetTypeAdapter extends TypeAdapter<SetType> {
  @override
  final typeId = 11;

  @override
  SetType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SetType.warmUp;
      case 1:
        return SetType.normal;
      case 2:
        return SetType.dropSet;
      case 3:
        return SetType.failure;
      case 4:
        return SetType.amrap;
      case 5:
        return SetType.cooldown;
      default:
        return SetType.warmUp;
    }
  }

  @override
  void write(BinaryWriter writer, SetType obj) {
    switch (obj) {
      case SetType.warmUp:
        writer.writeByte(0);
      case SetType.normal:
        writer.writeByte(1);
      case SetType.dropSet:
        writer.writeByte(2);
      case SetType.failure:
        writer.writeByte(3);
      case SetType.amrap:
        writer.writeByte(4);
      case SetType.cooldown:
        writer.writeByte(5);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlanDifficultyAdapter extends TypeAdapter<PlanDifficulty> {
  @override
  final typeId = 12;

  @override
  PlanDifficulty read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlanDifficulty.beginner;
      case 1:
        return PlanDifficulty.intermediate;
      case 2:
        return PlanDifficulty.advanced;
      default:
        return PlanDifficulty.beginner;
    }
  }

  @override
  void write(BinaryWriter writer, PlanDifficulty obj) {
    switch (obj) {
      case PlanDifficulty.beginner:
        writer.writeByte(0);
      case PlanDifficulty.intermediate:
        writer.writeByte(1);
      case PlanDifficulty.advanced:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanDifficultyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeightEntryAdapter extends TypeAdapter<WeightEntry> {
  @override
  final typeId = 13;

  @override
  WeightEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeightEntry(
      id: fields[0] as String,
      weightKg: (fields[1] as num).toDouble(),
      recordedAt: fields[2] as DateTime,
      bodyFatPercentage: (fields[3] as num?)?.toDouble(),
      muscleMassKg: (fields[4] as num?)?.toDouble(),
      note: fields[5] as String?,
      createdAt: fields[6] as DateTime?,
      updatedAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, WeightEntry obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.weightKg)
      ..writeByte(2)
      ..write(obj.recordedAt)
      ..writeByte(3)
      ..write(obj.bodyFatPercentage)
      ..writeByte(4)
      ..write(obj.muscleMassKg)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProgressPhotoAdapter extends TypeAdapter<ProgressPhoto> {
  @override
  final typeId = 14;

  @override
  ProgressPhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressPhoto(
      id: fields[0] as String,
      filePath: fields[1] as String,
      takenAt: fields[2] as DateTime,
      pose: fields[3] == null ? PhotoPose.front : fields[3] as PhotoPose,
      thumbnailPath: fields[4] as String?,
      weightKg: (fields[5] as num?)?.toDouble(),
      weightEntryId: fields[6] as String?,
      note: fields[7] as String?,
      isFavorite: fields[8] == null ? false : fields[8] as bool,
      createdAt: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ProgressPhoto obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.filePath)
      ..writeByte(2)
      ..write(obj.takenAt)
      ..writeByte(3)
      ..write(obj.pose)
      ..writeByte(4)
      ..write(obj.thumbnailPath)
      ..writeByte(5)
      ..write(obj.weightKg)
      ..writeByte(6)
      ..write(obj.weightEntryId)
      ..writeByte(7)
      ..write(obj.note)
      ..writeByte(8)
      ..write(obj.isFavorite)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressPhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final typeId = 15;

  @override
  Goal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goal(
      id: fields[0] as String,
      title: fields[1] as String,
      type: fields[2] as GoalType,
      startValue: (fields[3] as num).toDouble(),
      targetValue: (fields[4] as num).toDouble(),
      startedAt: fields[10] as DateTime,
      currentValue: (fields[5] as num?)?.toDouble(),
      unit: fields[6] == null ? 'kg' : fields[6] as String,
      direction: fields[7] == null
          ? GoalDirection.increase
          : fields[7] as GoalDirection,
      status: fields[8] == null ? GoalStatus.active : fields[8] as GoalStatus,
      description: fields[9] as String?,
      targetDate: fields[11] as DateTime?,
      achievedAt: fields[12] as DateTime?,
      exerciseId: fields[13] as String?,
      updatedAt: fields[14] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.startValue)
      ..writeByte(4)
      ..write(obj.targetValue)
      ..writeByte(5)
      ..write(obj.currentValue)
      ..writeByte(6)
      ..write(obj.unit)
      ..writeByte(7)
      ..write(obj.direction)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.startedAt)
      ..writeByte(11)
      ..write(obj.targetDate)
      ..writeByte(12)
      ..write(obj.achievedAt)
      ..writeByte(13)
      ..write(obj.exerciseId)
      ..writeByte(14)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalTypeAdapter extends TypeAdapter<GoalType> {
  @override
  final typeId = 16;

  @override
  GoalType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GoalType.bodyWeight;
      case 1:
        return GoalType.bodyFat;
      case 2:
        return GoalType.strength;
      case 3:
        return GoalType.endurance;
      case 4:
        return GoalType.consistency;
      case 5:
        return GoalType.custom;
      default:
        return GoalType.bodyWeight;
    }
  }

  @override
  void write(BinaryWriter writer, GoalType obj) {
    switch (obj) {
      case GoalType.bodyWeight:
        writer.writeByte(0);
      case GoalType.bodyFat:
        writer.writeByte(1);
      case GoalType.strength:
        writer.writeByte(2);
      case GoalType.endurance:
        writer.writeByte(3);
      case GoalType.consistency:
        writer.writeByte(4);
      case GoalType.custom:
        writer.writeByte(5);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalStatusAdapter extends TypeAdapter<GoalStatus> {
  @override
  final typeId = 17;

  @override
  GoalStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GoalStatus.active;
      case 1:
        return GoalStatus.achieved;
      case 2:
        return GoalStatus.missed;
      case 3:
        return GoalStatus.archived;
      default:
        return GoalStatus.active;
    }
  }

  @override
  void write(BinaryWriter writer, GoalStatus obj) {
    switch (obj) {
      case GoalStatus.active:
        writer.writeByte(0);
      case GoalStatus.achieved:
        writer.writeByte(1);
      case GoalStatus.missed:
        writer.writeByte(2);
      case GoalStatus.archived:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalDirectionAdapter extends TypeAdapter<GoalDirection> {
  @override
  final typeId = 18;

  @override
  GoalDirection read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GoalDirection.increase;
      case 1:
        return GoalDirection.decrease;
      default:
        return GoalDirection.increase;
    }
  }

  @override
  void write(BinaryWriter writer, GoalDirection obj) {
    switch (obj) {
      case GoalDirection.increase:
        writer.writeByte(0);
      case GoalDirection.decrease:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalDirectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhotoPoseAdapter extends TypeAdapter<PhotoPose> {
  @override
  final typeId = 19;

  @override
  PhotoPose read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PhotoPose.front;
      case 1:
        return PhotoPose.side;
      case 2:
        return PhotoPose.back;
      case 3:
        return PhotoPose.other;
      default:
        return PhotoPose.front;
    }
  }

  @override
  void write(BinaryWriter writer, PhotoPose obj) {
    switch (obj) {
      case PhotoPose.front:
        writer.writeByte(0);
      case PhotoPose.side:
        writer.writeByte(1);
      case PhotoPose.back:
        writer.writeByte(2);
      case PhotoPose.other:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoPoseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final typeId = 20;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      unitSystem: fields[0] == null
          ? UnitSystem.metric
          : fields[0] as UnitSystem,
      themePreference: fields[1] == null
          ? ThemePreference.system
          : fields[1] as ThemePreference,
      accentColorHex: fields[2] as String?,
      firstDayOfWeek: fields[3] == null ? 1 : (fields[3] as num).toInt(),
      restTimerSeconds: fields[4] == null ? 90 : (fields[4] as num).toInt(),
      autoStartRestTimer: fields[5] == null ? true : fields[5] as bool,
      restTimerSoundEnabled: fields[6] == null ? true : fields[6] as bool,
      hapticsEnabled: fields[7] == null ? true : fields[7] as bool,
      notificationsEnabled: fields[8] == null ? true : fields[8] as bool,
      keepScreenOnDuringWorkout: fields[9] == null ? true : fields[9] as bool,
      weeklyWorkoutGoal: fields[10] == null ? 4 : (fields[10] as num).toInt(),
      displayName: fields[11] as String?,
      heightCm: (fields[12] as num?)?.toDouble(),
      birthDate: fields[13] as DateTime?,
      sex: fields[14] == null
          ? BiologicalSex.unspecified
          : fields[14] as BiologicalSex,
      onboardingComplete: fields[15] == null ? false : fields[15] as bool,
      lastBackupAt: fields[16] as DateTime?,
      updatedAt: fields[17] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.unitSystem)
      ..writeByte(1)
      ..write(obj.themePreference)
      ..writeByte(2)
      ..write(obj.accentColorHex)
      ..writeByte(3)
      ..write(obj.firstDayOfWeek)
      ..writeByte(4)
      ..write(obj.restTimerSeconds)
      ..writeByte(5)
      ..write(obj.autoStartRestTimer)
      ..writeByte(6)
      ..write(obj.restTimerSoundEnabled)
      ..writeByte(7)
      ..write(obj.hapticsEnabled)
      ..writeByte(8)
      ..write(obj.notificationsEnabled)
      ..writeByte(9)
      ..write(obj.keepScreenOnDuringWorkout)
      ..writeByte(10)
      ..write(obj.weeklyWorkoutGoal)
      ..writeByte(11)
      ..write(obj.displayName)
      ..writeByte(12)
      ..write(obj.heightCm)
      ..writeByte(13)
      ..write(obj.birthDate)
      ..writeByte(14)
      ..write(obj.sex)
      ..writeByte(15)
      ..write(obj.onboardingComplete)
      ..writeByte(16)
      ..write(obj.lastBackupAt)
      ..writeByte(17)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UnitSystemAdapter extends TypeAdapter<UnitSystem> {
  @override
  final typeId = 21;

  @override
  UnitSystem read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UnitSystem.metric;
      case 1:
        return UnitSystem.imperial;
      default:
        return UnitSystem.metric;
    }
  }

  @override
  void write(BinaryWriter writer, UnitSystem obj) {
    switch (obj) {
      case UnitSystem.metric:
        writer.writeByte(0);
      case UnitSystem.imperial:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitSystemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemePreferenceAdapter extends TypeAdapter<ThemePreference> {
  @override
  final typeId = 22;

  @override
  ThemePreference read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemePreference.system;
      case 1:
        return ThemePreference.light;
      case 2:
        return ThemePreference.dark;
      default:
        return ThemePreference.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemePreference obj) {
    switch (obj) {
      case ThemePreference.system:
        writer.writeByte(0);
      case ThemePreference.light:
        writer.writeByte(1);
      case ThemePreference.dark:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemePreferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BiologicalSexAdapter extends TypeAdapter<BiologicalSex> {
  @override
  final typeId = 23;

  @override
  BiologicalSex read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BiologicalSex.unspecified;
      case 1:
        return BiologicalSex.male;
      case 2:
        return BiologicalSex.female;
      default:
        return BiologicalSex.unspecified;
    }
  }

  @override
  void write(BinaryWriter writer, BiologicalSex obj) {
    switch (obj) {
      case BiologicalSex.unspecified:
        writer.writeByte(0);
      case BiologicalSex.male:
        writer.writeByte(1);
      case BiologicalSex.female:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BiologicalSexAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseLibraryCategoryAdapter
    extends TypeAdapter<ExerciseLibraryCategory> {
  @override
  final typeId = 24;

  @override
  ExerciseLibraryCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExerciseLibraryCategory.chest;
      case 1:
        return ExerciseLibraryCategory.back;
      case 2:
        return ExerciseLibraryCategory.shoulders;
      case 3:
        return ExerciseLibraryCategory.biceps;
      case 4:
        return ExerciseLibraryCategory.triceps;
      case 5:
        return ExerciseLibraryCategory.legs;
      case 6:
        return ExerciseLibraryCategory.cardio;
      case 7:
        return ExerciseLibraryCategory.abs;
      default:
        return ExerciseLibraryCategory.chest;
    }
  }

  @override
  void write(BinaryWriter writer, ExerciseLibraryCategory obj) {
    switch (obj) {
      case ExerciseLibraryCategory.chest:
        writer.writeByte(0);
      case ExerciseLibraryCategory.back:
        writer.writeByte(1);
      case ExerciseLibraryCategory.shoulders:
        writer.writeByte(2);
      case ExerciseLibraryCategory.biceps:
        writer.writeByte(3);
      case ExerciseLibraryCategory.triceps:
        writer.writeByte(4);
      case ExerciseLibraryCategory.legs:
        writer.writeByte(5);
      case ExerciseLibraryCategory.cardio:
        writer.writeByte(6);
      case ExerciseLibraryCategory.abs:
        writer.writeByte(7);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseLibraryCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
