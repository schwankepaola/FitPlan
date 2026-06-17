class WorkoutModel {
  final String day;
  final String workout;

  WorkoutModel({
    required this.day,
    required this.workout,
  });

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'workout': workout,
    };
  }
}