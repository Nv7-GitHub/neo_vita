import 'package:flutter/material.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'dart:async';
import 'dart:math';

List shuffle(List items) {
  var random = new Random();

  for (var i = items.length - 1; i > 0; i--) {

    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}


class Memory extends StatefulWidget {
  Memory();

  @override
  _Memory createState() => _Memory();
}

class _Memory extends State<Memory> {
  int opened = 0;
  List<RevealBtn> btns;
  int tries = 0;
  int matches = 0;

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

  _Memory() {
    icons = new List(pics.length);
    for (int i = 0; i < pics.length; i++) {
      icons[i] = Icon(pics[i], size: 50);
    }
    start();
  }

  void start() {
    this.btns = new List(16);
    int len = this.icons.length;
    for (int i = 0; i < this.btns.length; i += len) {
      for (int j = 0; j < len; j++) {
        this.btns[i+j] = new RevealBtn(this.icons[j], this.handleOpen);
      }
    }
    this.btns = shuffle(this.btns);
  }

  handleOpen() {
    if (matches+1 == (this.btns.length ~/ 2)) {
      AlertDialog dialog = AlertDialog(
        title: Text("You finished!"),
        content: Text("You finished Memory in $tries tries!"),
        actions: <Widget>[
          TextButton(
            child: Text('Restart'),
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
        this.tries = 0;
        this.matches = 0;
        this.opened = 0;
        setState(this.start);
      });
      return;
    }

    opened++;
    int index1 = -1;
    int index2 = -1;
    if (opened > 2) {
      for (int i = 0; i < this.btns.length; i++) {
        if (!this.btns[i].revealed && !(this.btns[i].finished)) {
          opened--;
          if (index1 == -1) {
            index1 = i;
          } else {
            index2 = i;
          }
        }
      }

      if ((this.btns[index1].widget as Icon) == (this.btns[index2].widget as Icon)) {
        this.btns[index1].finished = true;
        this.btns[index2].finished = true;
        matches++;
      } else {
        this.btns[index1].change();
        this.btns[index2].change();
        tries++;
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: EdgeInsets.all(10),
      child: Align(
        child: GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          children: this.btns,
        )
      )
    );
  }
}

class RevealBtn extends StatefulWidget {
  final Widget widget;
  final VoidCallback callback;
  bool revealed = true;
  VoidCallback change;
  bool finished = false;
  RevealBtn(this.widget, this.callback);

  @override
  State<RevealBtn> createState() => _RevealBtn();
}

class _RevealBtn extends State<RevealBtn> with SingleTickerProviderStateMixin {
  final duration = Duration(milliseconds: 250);

  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    this.animationController = AnimationController(
      duration: this.duration,
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    this.animationController.forward();
    this.widget.change = this.change;
  }

  void change() {
    animationController.reverse();

    new Timer(this.duration, () {
      setState(() {
        this.widget.revealed = !this.widget.revealed;
      });
      animationController.forward();
    });
  }


  @override
  Widget build(BuildContext context) {
    return CircularRevealAnimation(
      child: this.widget.revealed ? Padding(
        padding: EdgeInsets.all(1),
        child: RaisedButton(
          child: Text("Reveal", style: TextStyle(color: Colors.white)),
          onPressed: () {
            this.widget.callback();
            animationController.reverse();

            new Timer(this.duration, () {
              setState(() {
                this.widget.revealed = false;
              });
              animationController.forward();
            });
          },
          color: Colors.blue,
        ),
      ) : this.widget.widget,
      animation: this.animation,
    );
  }
}