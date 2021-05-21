import 'package:flutter/material.dart';

class WorkoutCard extends StatefulWidget {
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
                      title: Text('hi'),
                      subtitle: Text(
                          'workout desasdlakjalskdjasdlkasjdalkdjasldkajlaskdjalkdjaldkajsdlkasjdlaskjdalskdjalskdjasldkasjdlaksjdalskdjaslkdjscription',
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
