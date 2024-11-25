import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_dev/login/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: GetMaterialApp(
      home: login(),
    ));
  }
}
