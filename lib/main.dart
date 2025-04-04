import 'package:flutter/material.dart';
import 'package:weather_app/Activity/home.dart';
import 'package:weather_app/Activity/loading.dart';
import 'package:weather_app/Activity/location.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Removes the red debug banner
    // home: home(), default route bana diya hai to iski jarurat nahi hai
    routes: {
      "/" : (context) => loading(),
      "/home" : (context) => home(),
      "/loading" : (context) => loading(),
    },
  ));
}

