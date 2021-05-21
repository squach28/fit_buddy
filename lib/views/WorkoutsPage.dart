import 'package:fit_buddy/views/components/AddWorkoutCard.dart';
import 'package:flutter/material.dart';
import 'package:fit_buddy/views/components/WorkoutCard.dart';

class WorkoutsPage extends StatefulWidget {
  @override
  WorkoutsPageState createState() => WorkoutsPageState();
}

class WorkoutsPageState extends State<WorkoutsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AddWorkoutCard(), WorkoutCard()]),
    ));
  }
}
