import 'package:flutter/material.dart';
import 'package:neo_vita/home.dart';
import 'package:neo_vita/games.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoVita',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: NeoVita(title: 'NeoVita'),
    );
  }
}

class NeoVita extends StatefulWidget {
  NeoVita({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _NeoVita createState() => _NeoVita();
}

class _NeoVita extends State<NeoVita> {
  int index = 0;
  final pages = <Widget>[
    new Home(),
    new Games(),
    Text("This will have a list of utilities like todo and calendar"),
  ];
  final pageNames = <String>["Home", "Games", "Utilities"];
  final icons = <Icon>[Icon(Icons.home), Icon(Icons.sports_esports), Icon(Icons.list)];
  List<Widget> drawer;
  List<NavigationRailDestination> destinations;

  bool isWide(BuildContext context) {
    return MediaQuery.of(context).size.width > 500;
  }

  @override
  Widget build(BuildContext context) {
    if (drawer == null) {
      this.drawer = new List(this.pageNames.length+1);
      this.drawer[0] = DrawerHeader(
        child: Text(
          "NeoVita",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      );
      this.destinations =  new List(this.pageNames.length);
      for (int i = 0; i < pageNames.length; i++) {
        this.drawer[i+1] = ListTile(
          title: Text(this.pageNames[i]),
          onTap: () {
            // Update the state of the app
            setState(() {this.index = i;});
            // Then close the drawer
            Navigator.pop(context);
          },
          leading: this.icons[i],
        );
        this.destinations[i] = NavigationRailDestination(
          icon: this.icons[i],
          selectedIcon: this.icons[i],
          label: Text(this.pageNames[i]),
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row (
        children: <Widget>[
          if (isWide(context)) NavigationRail(
            selectedIndex: this.index,
            onDestinationSelected: (int index) {
              setState(() {
                this.index = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: this.destinations,
          ),
          Expanded (
            child: Center(
              child: this.pages[this.index],
            )
          ),
        ],
      ),
      drawer: isWide(context) ? null : Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: this.drawer,
        )
      ),
    );
  }
}
