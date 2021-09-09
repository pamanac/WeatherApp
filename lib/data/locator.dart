import 'package:http/http.dart' as http;
import 'dart:convert';

class LocatorHelper {
  //URI: https://api.openweathermap.org/data/2.5/weather?q=London&appid=5f264c1eec85956f5b9cd2a2e5aded92

  final String authority = "geolocation-db.com";
  final String path = "json/";

  Future<String> getLocation() async {
    Uri uri = Uri.https(authority, path);
    http.Response result = await http.get(uri);

    Map<String, dynamic> data = json.decode(result.body);
    String city = data["city"];
    return city;
  }
}
