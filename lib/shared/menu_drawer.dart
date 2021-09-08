import 'package:flutter/material.dart';
import 'package:tutorial_app/screens/weather_screen.dart';
import '../screens/bmi_screen.dart';
import '../screens/intro_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildItems(context),
      ),
    );
  }

  List<Widget> buildItems(BuildContext context) {
    final List<String> titles = ["Home", "BMI", "Weather", "Training"];
    List<Widget> items = [];
    items.add(DrawerHeader(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child:
            Text("Menu", style: TextStyle(color: Colors.white, fontSize: 28))));

    titles.forEach((element) {
      Widget screen = Container();
      items.add(ListTile(
          title: Text(
            element,
            style: TextStyle(fontSize: 18),
          ),
          onTap: () {
            switch (element) {
              case 'Home':
                screen = IntroScreen();
                break;
              case 'BMI':
                screen = BmiScreen();
                break;
              case 'Weather':
                screen = WeatherScreen();
                break;
            }
            Navigator.of(context).pop(); //remove drawer
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));
          }));
    });

    return items;
  }
}
