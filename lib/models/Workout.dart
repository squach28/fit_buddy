import 'package:fit_buddy/models/Exercise.dart';
// class that contains the information about a workout
class Workout {
  final String title;
  final String description;
  final String createdBy;
  final int sets;
  final List<Exercise> exercises;

  Workout(
      {this.title,
      this.description,
      this.createdBy,
      this.sets,
      this.exercises});

    // takes the list of exercises and parses it to json 
    List<Map<String, dynamic>> exercisesToJson() {
      List<Map<String, dynamic>> exerciseJsonResult = [];
      for(var exercise in this.exercises) {
        exerciseJsonResult.add(exercise.toJson());
      }
      return exerciseJsonResult;
    }

    // workout formatted as json
    Map<String, dynamic> toJson() => {
      'title': this.title,
      'description': this.description,
      'createdBy': this.createdBy,
      'sets': this.sets,
      'exercises': exercisesToJson() ,
    };
}
