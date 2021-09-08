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
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                      controller: txtPlace,
                      decoration: InputDecoration(
                          hintText: "City",
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search), onPressed: getData))),
                ),
                weatherRow('Place: ', result.name),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: weatherRow('Description: ', result.description)),
                    Expanded(
                      flex: 1,
                      child: result.description == "Clouds" //To improve
                          ? Icon(Icons.cloud)
                          : Icon(Icons.ac_unit),
                    )
                  ],
                ),
                weatherRow(
                    'Temperature: ', result.temperature.toStringAsFixed(2)),
                weatherRow('Perceived: ', result.perceived.toStringAsFixed(2)),
                weatherRow('Pressure: ', result.pressure.toString()),
                weatherRow('Humidity: ', result.humidity.toString()),
              ],
            )));
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
