import 'package:http/http.dart';
import 'dart:convert';

class worker{

  late String location;
  worker({required this.location}){
    this.location = location;
  }
  //Makes location a named parameter (indicated by the curly braces {})
  // Marks the parameter as required, which means it must be provided when creating an instance

  // use late so we dont have to initialise
  late String lat; // latitude
  late String lon; //longitude
  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;
    String city = "Bhopal" ;


  Future<void> getData() async {

    try {
      print("Fetching weather for: $location");
      // to get latitude and longitude
      Uri url2 = Uri.parse("https://api.openweathermap.org/geo/1.0/direct?q=$location&limit=5&appid=f7d71023cffedc9ed3ada06bd5785e54");
      Response response2 = await get(url2);
      List data2 = jsonDecode(response2.body);
      //String location = data2[0];
      String getLat = data2[0]['lat'].toString();
      String getLon = data2[0]['lon'].toString();
      print("Latitude: $getLat, Longitude: $getLon");

      Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$getLat&lon=$getLon&appid=f7d71023cffedc9ed3ada06bd5785e54");
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      print("API Response: $data"); // Debugging


      //getting temp, humidity, wind speed
      Map temp_data = data['main'];
      double gettemp = temp_data['temp'] - 273.15;
      String gethumidity = temp_data['humidity'].toString();

      Map wind = data['wind'];
      double getair_speed = wind['speed']*3.6; // convert from m/s to km/hr

      //getting description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getmain_des = weather_main_data['main'];    // clear
      String getdesc = weather_main_data['description']; // clear sky


      // assigning values in variable
      temp = gettemp.toStringAsFixed(2); // celsius (2 decimal places)
      humidity = gethumidity; //%
      air_speed = getair_speed.toStringAsFixed(2); //km/hr
      description = getdesc.toString();
      main = getmain_des.toString();
      icon = weather_main_data["icon"].toString();
    } catch(e){
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "can't find data";
      main = "NA";
      icon = "09d"; //give rain symbol for error
    }

  }
 }

