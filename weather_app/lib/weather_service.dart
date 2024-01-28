import 'weather_model.dart';
import 'weather_repository.dart';

class WeatherService {
  final WeatherRepository _repository;

  WeatherService(this._repository);

  Future<Weather> getWeather(String city) async {
    final weatherData = await _repository.getWeather(city);

    final cityName = weatherData['name'];
    final temperature = weatherData['main']['temp'];
    final description = weatherData['weather'][0]['description'];

    Weather weather = Weather(
        cityName: cityName, temperature: temperature, description: description);
    await _repository.saveWeather(cityName, temperature, description);
    return weather;
  }
}
