import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/services/WorkoutService.dart';
import 'package:fit_buddy/views/AddWorkoutPage.dart';
import 'package:flutter/material.dart';
import 'package:fit_buddy/views/components/WorkoutCard.dart';

class WorkoutsPage extends StatefulWidget {
  @override
  WorkoutsPageState createState() => WorkoutsPageState();
}

class WorkoutsPageState extends State<WorkoutsPage> {
  final workoutService = WorkoutService();

  Widget workoutsPageHeader() {
    return Text('Workouts',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32.0));
  }

  Widget workoutsList() {
    return FutureBuilder(
        future: workoutService.getWorkouts(),
        builder: (context, snapshot) {
          final workouts = snapshot.data.docs;

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: workouts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: WorkoutCard(
                title: workouts.elementAt(index).get('title'),
              ));
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                  child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      workoutsPageHeader(),
                      workoutsList()
                    ]),
              )))),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddWorkoutPage()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
