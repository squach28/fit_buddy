// enum for a type of exercise

enum ExerciseType {
  TIMED,
  REPS
}

extension ParseToString on ExerciseType {
  String toShortString() {
    String exerciseType = this.toString().split('.').last;
    exerciseType = exerciseType[0] + exerciseType.substring(1, exerciseType.length).toLowerCase();
    return exerciseType;
  }
}