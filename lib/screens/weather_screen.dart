import 'package:flutter/material.dart';
import 'package:tutorial_app/data/locator.dart';
import 'package:tutorial_app/data/weather.dart';
import 'package:intl/intl.dart';
import '../data/http_helper.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('hh:mm');

  Weather result = Weather('', '', 0, 0, 0, 0);

  bool isMetric = true;
  bool isImperial = false;
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  final TextEditingController txtPlace = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Weather")),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("world.jpg"), fit: BoxFit.cover)),
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  Align(
                    child: Row(
                      children: [
                        Container(
                            width: 150.0,
                            child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: txtPlace,
                                decoration: InputDecoration(
                                    hintText: "City",
                                    hintStyle: TextStyle(color: Colors.white),
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.search,
                                            color: Colors.white),
                                        onPressed: getData)))),
                        IconButton(
                          icon: Icon(
                            Icons.location_city,
                            color: Colors.white,
                          ),
                          onPressed: getCity,
                        )
                      ],
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    child: Text(formatter.format(now),
                        style: TextStyle(color: Colors.white)),
                    alignment: Alignment.topRight,
                  ),
                  Align(
                    child: Container(
                        height: 100.0,
                        width: 300.0,
                        child: ListView(
                          children: [
                            //weatherRow('Perceived: ', result.perceived.toStringAsFixed(2)),
                            Row(children: [
                              Icon(
                                Icons.access_alarm,
                                color: Colors.white,
                              ),
                              Text(result.perceived.toStringAsFixed(2),
                                  style: TextStyle(color: Colors.white))
                            ]),

                            //weatherRow('Pressure: ', result.pressure.toString()),
                            Row(children: [
                              Icon(Icons.add_sharp, color: Colors.white),
                              Text(result.pressure.toString(),
                                  style: TextStyle(color: Colors.white))
                            ]),

                            //weatherRow('Humidity: ', result.humidity.toString()),
                            Row(children: [
                              Icon(Icons.window, color: Colors.white),
                              Text(result.humidity.toString(),
                                  style: TextStyle(color: Colors.white))
                            ]),
                          ],
                        )),
                    alignment: Alignment.bottomLeft,
                  ),
                  Align(
                    child: Container(
                        width: 150.0,
                        height: 100.0,
                        child: //weatherRow(
                            //'', result.temperature.toStringAsFixed(2))
                            Column(
                          children: [
                            Text(
                                (isMetric
                                        ? result.temperature.toStringAsFixed(2)
                                        : (result.temperature * (9 / 5) + 32)
                                            .toStringAsFixed(2)) +
                                    "\u00B0", //this is degree sign
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white)),
                            ToggleButtons(children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text("Metric",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white))),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text("Imperial",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white)))
                            ], isSelected: isSelected, onPressed: toggleMeasure)
                          ],
                        )),
                    alignment: Alignment.bottomRight,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        result.description == ""
                            ? Text('')
                            : //Icon(fetchIcon(result.description),
                            fetchImage(result.description),
                        Text(result.description,
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  )
                ],
              )),
        ));
    /*
          Padding(
          padding: EdgeInsets.all(16)
          */
    /*
          TextField(
                    controller: txtPlace,
                    decoration: InputDecoration(
                        hintText: "City",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search), onPressed: getData)))
          */
    /*weatherRow('Place: ', result.name),
                weatherRow('Description: ', result.description),
                weatherRow(
                    'Temperature: ', result.temperature.toStringAsFixed(2)),
                weatherRow('Perceived: ', result.perceived.toStringAsFixed(2)),
                weatherRow('Pressure: ', result.pressure.toString()),
                weatherRow('Humidity: ', result.humidity.toString()), */
  }

  Future getData() async {
    HttpHelper helper = HttpHelper();
    result = await helper.getWeather(txtPlace.text);
    setState(() {
      now = DateTime.now();
    });
  }

  Future getCity() async {
    LocatorHelper location_helper = LocatorHelper();
    HttpHelper http_helper = HttpHelper();
    result = await http_helper.getWeather(await location_helper.getLocation());
    txtPlace.text = result.getName();
    setState(() {
      now = DateTime.now();
    });
  }

  Widget weatherRow(String label, String value) {
    Widget row = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                label,
                style:
                    TextStyle(fontSize: 20, color: Theme.of(context).hintColor),
              )),
          Expanded(
              flex: 4,
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              )),
        ],
      ),
    );

    return row;
  }

  void toggleMeasure(index) {
    switch (index) {
      case 0:
        isMetric = true;
        isImperial = false;
        break;
      case 1:
        isMetric = false;
        isImperial = true;
        break;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }
}

IconData fetchIcon(String type) {
  switch (type) {
    case "Clouds":
      return Icons.cloud;
    case "Clear":
      return Icons.wb_sunny;
    default:
      return Icons.error;
  }
}

Image fetchImage(String type) {
  switch (type) {
    case "Clouds":
      return Image.asset(
        "cloud.png",
        height: 200,
        width: 200,
      );
    case "Clear":
      return Image.asset(
        "sun2.png",
        height: 200,
        width: 200,
      );
    case "Rain":
      return Image.asset(
        "rain.png",
        height: 200,
        width: 200,
      );
    default:
      return Image.asset(
        "cloud.png",
        height: 200,
        width: 200,
      );
  }
}
