import 'package:flutter/material.dart';
import 'package:tutorial_app/data/weather.dart';
import '../data/http_helper.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Weather result = Weather('', '', 0, 0, 0, 0);
  final TextEditingController txtPlace = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Weather")),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Align(
                  child: Container(
                      width: 100.0,
                      child: TextField(
                          controller: txtPlace,
                          decoration: InputDecoration(
                              hintText: "City",
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: getData)))),
                  alignment: Alignment.topLeft,
                ),
                Align(
                  child: Text("12:00"),
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
                            Icon(Icons.access_alarm),
                            Text(result.perceived.toStringAsFixed(2))
                          ]),

                          //weatherRow('Pressure: ', result.pressure.toString()),
                          Row(children: [
                            Icon(Icons.add_sharp),
                            Text(result.pressure.toString())
                          ]),

                          //weatherRow('Humidity: ', result.humidity.toString()),
                          Row(children: [
                            Icon(Icons.safety_divider),
                            Text(result.humidity.toString())
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
                          Text(result.temperature.toStringAsFixed(2),
                              style: TextStyle(fontSize: 40))),
                  alignment: Alignment.bottomRight,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      result.description == ""
                          ? Text('')
                          : Icon(fetchIcon(result.description)),
                      Text(result.description)
                    ],
                  ),
                )
              ],
            )));
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
    setState(() {});
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
}

IconData fetchIcon(String type) {
  switch (type) {
    case "Clouds":
      return Icons.cloud;
    default:
      return Icons.ice_skating;
  }
}
