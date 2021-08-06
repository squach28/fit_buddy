import 'package:flutter/material.dart';
import 'package:fit_buddy/models/ExerciseType.dart';

// represents a widget for an exercise card
// meant for a specific exercise, as opposed to a workout (workout contains list of exercises)
class ExerciseCard extends StatefulWidget {
  @override
  ExerciseCardState createState() => ExerciseCardState();
}

class ExerciseCardState extends State<ExerciseCard> {
  ExerciseType exerciseType = ExerciseType.TIMED;

  // widget to represent how much of the exercise should be done
  // param: exerciseType - an enum that represents the type of the exercise
  Widget exerciseAmountWidget(ExerciseType exerciseType) {
    switch (exerciseType) {
      case ExerciseType.TIMED:
        {
          return Container(
              width: 150,
              height: 50,
              child: Form(
                  child: Row(children: [
                Expanded(
                    child: TextFormField(keyboardType: TextInputType.number)),
                Text('min'),
                Expanded(
                    child: TextFormField(keyboardType: TextInputType.number)),
                Text('sec')
              ])));
        }

      case ExerciseType.REPS:
        {
          return Container(width: 150, height: 50,
          child: Form(child: Row(children: [
            Container(width: 30,child: TextFormField(
              keyboardType: TextInputType.number
            )),
            Text('reps'),
          ])));
        }

      default:
        {
          return Text('default');
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 4,
        child: Card(
          elevation: 2.5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Form(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Exercise Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none)),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(children: [
                    Text('Type'),
                    SizedBox(width: 10.0),
                    DropdownButton<ExerciseType>(
                      value: this.exerciseType,
                      onChanged: (ExerciseType newValue) {
                        setState(() {
                          this.exerciseType = newValue;
                        });
                      },
                      items: <ExerciseType>[
                        ExerciseType.TIMED,
                        ExerciseType.REPS
                      ].map<DropdownMenuItem<ExerciseType>>(
                          (ExerciseType value) {
                        return DropdownMenuItem<ExerciseType>(
                            value: value, child: Text(value.toShortString()));
                      }).toList(),
                    ),
                    SizedBox(width: 40.0),
                    exerciseAmountWidget(this.exerciseType),
                  ])),
            ]),
          ),
        ));
  }
}
