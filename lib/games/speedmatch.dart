import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class SpeedMatch extends StatefulWidget {
  _SpeedMatch createState() => _SpeedMatch();
}

class _SpeedMatch extends State<SpeedMatch> {
  Random rand = new Random();
  int score = 0;
  Icon previous;
  Icon current = Icon(Icons.play_arrow, size: 50);
  List<IconData> pics = <IconData>[
    Icons.sports_football,
    Icons.local_fire_department,
    Icons.map,
    Icons.pedal_bike,
    Icons.tour,
    Icons.waves,
    Icons.create,
    Icons.dangerous,
  ];
  List<Icon> icons;
  Timer timer;

  @override
  void initState() {
    super.initState();
    icons = new List(pics.length);
    for (int i = 0; i < pics.length; i++) {
      icons[i] = Icon(pics[i], size: 50);
    }
    startTimer();
  }

  void timerCallback() {
    if (this.previous != null) {
      this.timer.cancel();
      this.failureDialog(
          "You took just a little too long this time, try to be faster next time!");
    }
  }

  void failureDialog(String text) {
    AlertDialog dialog = AlertDialog(
      title: Text("Out of time!"),
      content: Text("$text You scored $score!"),
      actions: <Widget>[
        TextButton(
          child: Text('Try Again'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (context) => dialog,
    ).then((val) {
      setState(() {
        this.score = 0;
        this.previous = null;
        this.current = Icon(Icons.play_arrow, size: 50);
        startTimer();
      });
    });
  }

  void startTimer() {
    Duration duration = new Duration(milliseconds: 1000 - (score * 5));
    this.timer = new Timer(duration, this.timerCallback);
  }

  void updateIcon() {
    setState(() {
      this.previous = this.current;
      this.current = this.icons[rand.nextInt(this.icons.length)];
    });
  }

  void check(bool equal) {
    this.timer.cancel();
    if (((this.previous == this.current) == equal) || (this.previous == null)) {
      this.score++;
      updateIcon();
      startTimer();
    } else {
      String text = "";
      if (equal) {
        text = "'nt";
      }
      this.failureDialog("Oops! Those did$text match!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Is this picture the same as before?",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              )),
          Expanded(
            flex: 85,
            child: Align(
              child: this.current,
              alignment: Alignment.center,
            ),
          ),
          Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                    child: Text("No", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      this.check(false);
                    },
                    color: Colors.blue,
                  )),
                  Expanded(
                      child: RaisedButton(
                    child: Text("Yes", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      this.check(true);
                    },
                    color: Colors.blue,
                  )),
                ],
              )),
        ]);
  }
}
