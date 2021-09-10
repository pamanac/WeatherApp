import 'package:flutter/material.dart';
import 'package:tutorial_app/screens/bmi_screen.dart';
import 'package:tutorial_app/screens/intro_screen.dart';
import 'package:tutorial_app/screens/weather_screen.dart'; 

//Entry point
void main() {
  runApp(//inflates widget and displays it to screen
      MyApp());
}

class MyApp extends StatelessWidget {
  //extends -> inheritance
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // main container for Material Design apps
      //Center( // Container Widget that centers the contents
      //child: Text("Hello World"), //Child allows you to nest widgets
      theme: ThemeData(
          primarySwatch:
              Colors.blueGrey), //swatch affects many parts of the widget
      routes: {
        // route : builder
        '/': (context) => WeatherScreen(),
        '/bmi': (context) => BmiScreen(),
        '/weather' : (context) => WeatherScreen()
      },
      initialRoute: '/',
    );
  }
}
