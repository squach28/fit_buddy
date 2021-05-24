import 'package:fit_buddy/models/Exercise.dart';

// represents an exercise that is time based
class TimedExercise extends Exercise {
  final String name;
  final double time; // in seconds 

  TimedExercise({this.name, this.time});

  // formats the timed exercise to json 
  @override 
  Map<String, dynamic> toJson() => {
    'name': this.name,
    'time': this.time
  };
}