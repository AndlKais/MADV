import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final String apiKey;
  final String apiUrl = "http://api.openweathermap.org/data/2.5/weather";
  final CollectionReference weatherCollection =
  FirebaseFirestore.instance.collection('weather');

  WeatherRepository(this.apiKey);

  Future<Map<String, dynamic>> getWeather(String city) async {
    final response =
        await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey&units=metric'));
    return json.decode(response.body);
  }

  Future<void> saveWeather(
      String city, double temperature, String description) async {
    await weatherCollection.add({
      'city': city,
      'temperature': temperature,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
