import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "NeoVita",
            style: Theme.of(context).textTheme.headline5,
          )
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7.5, 5, 7.5, 5),
          child: Text(
            "Welcome to NeoVita! Neo- means New, and Vita means life, so NeoVita means 'New Life'! NeoVita is a collection of games and utilities to help seniors with their memory, cognition, and day-to-day life in general.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          )
        )
      ]
    );
  }
}