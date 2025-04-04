import 'package:flutter/material.dart';
import 'package:weather_app/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {

  String city = "Bhopal";
  String? _lastProcessedCity;
  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;

  void startApp(String city) async {
    worker instance = worker(location: city); //instance is just name of object of class wroker
     await instance.getData();
     temp = instance.temp;
     humidity = instance.humidity;
     air_speed = instance.air_speed;
     description = instance.description;
     main = instance.main;
     icon = instance.icon;
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp, // key value pair in dict
        "hum_value": humidity,
        "air_speed_value": air_speed,
        "des_value": description,
        "main_value": main,
        "icon_value": icon,
        "city_value": city
      });
  }
  
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get search parameters
    Map<dynamic, dynamic>? search = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;
    if (search?.isNotEmpty ?? false) {
      city = search?['searchText'] ?? "Bhopal"; // kuch search nai kiya to default bhopal
    }

    // Only start if this is a new city
    if (_lastProcessedCity != city) {
      _lastProcessedCity = city; // Remember this city
      startApp(city);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 180,),
              Image.asset("images/Loading_page_logo.png"),
              Text("Meteo",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),),
              SizedBox(height: 10),
              Text("Made by Yash",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),),
              SizedBox(height: 30,),
              SpinKitFadingCube(
              color: Colors.blue.shade600,
              size: 50.0,
            ),
            ]
          )
        ),
      ),
          backgroundColor: Colors.lightBlue[200],
      );
  }
}


