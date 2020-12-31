import 'package:flutter/material.dart';
import 'package:neo_vita/games/memory.dart';
import 'package:neo_vita/games/speedmatch.dart';

class Games extends StatelessWidget {
  final games = <Widget>[
    new Memory(),
    new SpeedMatch(),
  ];
  final gameNames = <String>[
    "Memory",
    "Speed Match",
  ];
  List<Widget> widgets;

  Games() {
    widgets = new List(games.length);
    for (int i = 0; i < games.length; i++) {
      widgets[i] = new PlayGame(gameNames[i], games[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: this.widgets,
    );
  }
}

class PlayGame extends StatefulWidget {
  final Widget game;
  final String title;
  PlayGame(this.title, this.game);

  @override
  _PlayGame createState() => _PlayGame(this.title, this.game);
}

class _PlayGame extends State<PlayGame> {
  final Widget game;
  final String title;
  bool playing = true;
  _PlayGame(this.title, this.game);

  void playGame() {
    setState((){
      this.playing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return playing ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.title,
          style: Theme.of(context).textTheme.headline5,
        ),
        RaisedButton(
          child: Text(
            "Play Game!",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: playGame,
          color: Colors.blue,
        )
      ]
    ) : this.game;
  }
}