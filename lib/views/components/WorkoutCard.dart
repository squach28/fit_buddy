import 'package:flutter/material.dart';


class WorkoutCard extends StatefulWidget {

  final String title;
  final String description;
  WorkoutCard({this.title, this.description});
  
  @override
  WorkoutCardState createState() => WorkoutCardState();
}

class WorkoutCardState extends State<WorkoutCard> {
  bool favorite = false; // TODO favorited, check if user has the workout in favorites list
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 4,
        child: GestureDetector(
            onTap: () {
              // TODO go to workout general page
            },
            child: Card(
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(children: [
                  ListTile(
                      title: Text(widget.title),
                      subtitle: Text(
                          widget.description,
                          maxLines: 2),
                      isThreeLine: true,
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              favorite = !favorite;
                            });
                          },
                          icon: favorite
                              ? Icon(Icons.star, size: 30.0)
                              : Icon(Icons.star_border, size: 30.0))),
                ]))));
  }
}
