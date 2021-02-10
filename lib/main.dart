import 'package:billy/get/debts_controller.dart';
import 'package:billy/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(DebtsController());
  runApp(
    GetMaterialApp(
      home: HomeScreen(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Billy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        accentColor: Colors.amberAccent,
      ),
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}
