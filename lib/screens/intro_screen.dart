import 'package:flutter/material.dart';
import 'package:tutorial_app/shared/menu_bottom.dart';
import 'package:tutorial_app/shared/menu_drawer.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(title: Text("Hello")),
        bottomNavigationBar: MenuBottom(),
        body: Container(
          //you can decorate it
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("ice.jpeg"), fit: BoxFit.cover)),
          child: Center(
              child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.black87, borderRadius: BorderRadius.circular(10)),
            child: Text("I am a text you must be able to read",
                style: (TextStyle(fontSize: 22, shadows: [
                  Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 2.0,
                      color: Colors.blue)
                ]))),
          )),
        ));
  }
}

