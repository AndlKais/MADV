import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'weather_model.dart';
import 'weather_repository.dart';
import 'weather_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService =
      WeatherService(WeatherRepository("c3babc169a969a10b85c3477c8cc2485"));

  String _city = "";
  Weather? _weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'Enter City'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final city = _cityController.text;
                final weather = await _weatherService.getWeather(city);
                setState(() {
                  _city = city;
                  _weather = weather;
                });
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 16),
            _weather != null
                ? Column(
                    children: [
                      Text('City: $_city'),
                      Text('Temperature: ${_weather!.temperature}°C'),
                      Text('Description: ${_weather!.description}'),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
