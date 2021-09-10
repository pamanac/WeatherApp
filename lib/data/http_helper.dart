import 'dart:html';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'locator.dart';

import 'package:tutorial_app/data/weather.dart';

class HttpHelper {
  //URI: https://api.openweathermap.org/data/2.5/weather?q=London&appid=5f264c1eec85956f5b9cd2a2e5aded92

  final String authority = "api.openweathermap.org";
  final String path = "/data/2.5/weather";
  final String apiKey = "5f264c1eec85956f5b9cd2a2e5aded92";

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appId': apiKey};

    Uri uri = Uri.https(authority, path, parameters);
    try {
      print("trying to fetch");
      http.Response result = await http.get(uri);
      print("This succeeded");
      Map<String, dynamic> data = json.decode(result.body);
      Weather weather = Weather.fromJson(data);
      return weather;
    } catch (e) {
      print("In catch block");
      /*LocatorHelper locationHelper = LocatorHelper();
      String location = await locationHelper.getLocation();
      Map<String, dynamic> params = {
        'q': location,
        'appId': apiKey
      };

      uri = Uri.https(authority, path, params);
      http.Response result = await http.get(uri);
      Map<String, dynamic> data = json.decode(result.body);
      Weather weather = Weather.fromJson(data);
      return weather;
      */
      Weather result = Weather('ERROR', '', 0, 0, 0, 0);
      return result;
    }
  }
}
