import 'package:fit_buddy/views/AddWorkoutPage.dart';
import 'package:flutter/material.dart';
import 'package:fit_buddy/views/components/WorkoutCard.dart';

class WorkoutsPage extends StatefulWidget {
  @override
  WorkoutsPageState createState() => WorkoutsPageState();
}

Widget workoutsPageHeader() {
  return Text('Workouts',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32.0));
}

class WorkoutsPageState extends State<WorkoutsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [workoutsPageHeader(), WorkoutCard()]),
              ))),
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
