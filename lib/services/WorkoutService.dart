import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/models/Workout.dart';
import 'package:fit_buddy/services/AuthenticationService.dart';

class WorkoutService {
  final firestore = FirebaseFirestore.instance;
  final authenticationService = AuthenticationService();

  // adds a workout to the public collection 
  Future<DocumentReference<Object>> insertPublicWorkout(Workout workout) {
    CollectionReference workouts = firestore.collection('workouts');
    Map<String, dynamic> workoutAsJson = workout.toJson();
    return workouts.add(workoutAsJson);
  }

  // add the workout to the user's private collection
  Future<void> insertPrivateWorkout(Workout workout, String id) {}
}
