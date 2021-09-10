class Weather {
  String name = '';
  String description = '';
  double temperature = 0;
  double wind = 0;
  int pressure = 0;
  int humidity = 0;

  Weather(this.name, this.description, this.temperature, this.wind,
      this.pressure, this.humidity);

  Weather.fromJson(Map<String, dynamic> weatherMap) {
    this.name = weatherMap['name'];
    this.temperature = weatherMap['main']['temp'] - 273.15 ?? 0;
    this.wind = weatherMap['wind']['speed'] * 1.60934;
    this.pressure = weatherMap['main']['pressure'] ?? 0;
    this.humidity = weatherMap['main']['humidity'] ?? 0;

    this.description = weatherMap['weather'][0]['main'] ?? '';
  }

  String getName() {
    return this.name;
  }

  String getWeather() {
    return this.description;
  }
}
