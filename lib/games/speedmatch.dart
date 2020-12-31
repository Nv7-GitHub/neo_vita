import 'package:flutter/material.dart';
import 'dart:math';

class SpeedMatch extends StatefulWidget {
    _SpeedMatch createState() => _SpeedMatch();
}

class _SpeedMatch extends State<SpeedMatch> {
  Random rand = new Random();
  int score = 0;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded (
          flex: 5,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Is this picture the same as before?",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          )
        ),
        Expanded (
          flex: 85,
          child: Align(
            child: Icon(
              Icons.admin_panel_settings,
              size: 300,
            ),
            alignment: Alignment.center,
          ),
        ),
        Expanded (
          flex: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded (
                  child: RaisedButton(
                    child: Text("No", style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                    color: Colors.blue,
                  )
              ),
              Expanded (
                  child: RaisedButton(
                    child: Text("Yes", style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                    color: Colors.blue,
                  )
              ),
            ],
          )
        ),
      ]
    );
  }
}
