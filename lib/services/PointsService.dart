import 'package:cloud_firestore/cloud_firestore.dart';

class PointsService {
  final firestore = FirebaseFirestore.instance;


  // creates a profile in the points collection for the current user
  // parameters: uid - the uid of the user 
  //             name - the name of the user
  Future<void> createProfile(String uid, String name) {
    CollectionReference points = firestore.collection('points');
    return points.doc(uid).set({
      'uid': uid,
      'name': name,
      'points': 0
    });
  }

  // checks if a profile already exists 
  // parameter: uid - the uid of the profile to check
  Future<bool> profileExists(String uid) async {
    final profile = await firestore.collection('points').doc(uid).get();
    
    return profile.exists;
  }

  Stream pointsProfileStream(String uid) {
    return firestore.collection('points').doc(uid).snapshots();
  }



}
