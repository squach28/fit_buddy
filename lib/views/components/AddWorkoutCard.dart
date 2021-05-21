import 'package:flutter/material.dart';

class AddWorkoutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 4,
        child: GestureDetector(
            onTap: () {
              // TODO navigate to add workout page
            },
            child: Card(
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: Icon(Icons.add))))));
  }
}
