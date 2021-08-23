import 'package:flutter/material.dart';
import 'package:scherben_boot/dependecy_injection/container.dart';
import 'package:scherben_boot/services/services.module.dart';
import 'package:scherben_boot/views/home_view.dart';

void main() {
  container.addModule(ServicesModule());
  runApp(ScherbenBoot());
}

class ScherbenBoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scherbenboot',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey[500],
        ),
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: Home(),
    );
  }
}
