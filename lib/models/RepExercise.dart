import 'package:fit_buddy/models/Exercise.dart';

// represents an exercise that is meant to do in reps
class RepExercise extends Exercise {
  final String name;
  final int reps; // number of reps

  RepExercise({this.name, this.reps});

  @override 
    Map<String, dynamic> toJson() => {
    'name': this.name,
    'reps': this.reps
  };
}