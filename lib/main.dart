import 'package:flutter/material.dart';
import 'package:motivatiup/pages/homeScreen.dart';
import 'package:motivatiup/splashScreen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenEkrani(),
    ),
  );
}
