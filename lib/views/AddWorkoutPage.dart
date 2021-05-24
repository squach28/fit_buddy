import 'package:fit_buddy/views/components/ExerciseCard.dart';
import 'package:flutter/material.dart';

class AddWorkoutPage extends StatefulWidget {
  @override
  AddWorkoutPageState createState() => AddWorkoutPageState();
}

class AddWorkoutPageState extends State<AddWorkoutPage> {
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Create Workout'),
        ),
        body: Form(
            child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Details'),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        fillColor: Color(0xffebedf0),
                        filled: true,
                        hintText: 'Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none)),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 7,
                        child: TextFormField(
                          expands: true,
                          textInputAction: TextInputAction.next,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            fillColor: Color(0xffebedf0),
                            filled: true,
                            hintText: 'Description',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none)),
                          ),
                        )),
                    Text('Sets'),
                    Row(
                      children: [
                        Expanded(child: Text('Number of sets')),
                        SizedBox(width: 30.0),
                        Container(
                            height: 50,
                            width: 75,
                            child: DropdownButton<int>(
                              value: dropdownValue,
                              onChanged: (int newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <int>[1, 2, 3, 4]
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()));
                              }).toList(),
                            )),
                      ],
                    ),
                    Text('Exercises'),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return ExerciseCard();
                        }),
                  ],
                )))));
  }
}
