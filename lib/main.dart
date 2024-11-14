import 'package:flutter/material.dart';
import 'package:projectfleet/views/home.page.dart';
import 'package:projectfleet/views/login.view.dart';
 // Assurez-vous que vous avez créé ce fichier

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login', // Vue initiale
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => MyHomePage(userName: 'Fatima Zahra'),
      },
    );
  }
}
