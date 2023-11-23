import 'package:flutter/material.dart';
import 'todoHomepage/todo_homepage.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo-List',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0x94A0EAFF),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ToDo-App'),
      debugShowCheckedModeBanner: false,
    );
  }
}