import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController searchcontroller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("this is init state");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("set state called");
  }

  @override
  void dispose() {
    super.dispose();
    print("widget destroyed");
  }

  @override
  Widget build(BuildContext context) {
    Map info = ModalRoute.of(context)?.settings.arguments as Map<dynamic,dynamic> ;
    String temp = ((info['temp_value']).toString());
    String wind = ((info["air_speed_value"]).toString());
    if(temp=="NA"){
      print("NA");
    }
    else{
      //error nahi aa raha tabhi substring karo pehle karne ki jarurat nahi hai
      temp = ((info['temp_value']).toString()).substring(0,4); //4 numbers ka ans dega ex: 31.4
      wind = ((info["air_speed_value"]).toString()).substring(0,4);
    }
    String icon = info["icon_value"];
    String city = info["city_value"];
    String hum = info["hum_value"];
    String des = info["des_value"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: PreferredSize(preferredSize: Size.fromHeight(0), child:
        AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade300], // Gradient colors
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),),

      body: SingleChildScrollView( //single child scroll view taki diff phn size me scroll ho jaye upr niche
        child: SafeArea(
          // app bar k niche se kam shuru ho per abhi app bar nahi hai to SafeArea ka use kiya
          child: Container(
            // use container for styling, padding, margins, decoration,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue.shade800, Colors.blue.shade300])),
            child: Column(
              children: [
                Container(
                  // search wala container
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  margin: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 25,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchcontroller.text).replaceAll(" ", "") == ""){ // space karne per search kar raha tha toh space ko replace karke empty kar diya
                            print("blank space");
                          }
                          else {
                          Navigator.pushReplacementNamed(context, "/loading", arguments: {
                            "searchText" : searchcontroller.text, //Retrieving user input
                          }, );
                            print(searchcontroller.text);
                          }
                        },
                        child: Container(
                            child: Icon(Icons.search_rounded),
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchcontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search any city name"),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Image.network("https://openweathermap.org/img/wn/$icon@2x.png"), // to get image from internet
                            SizedBox(width: 15),
                            Column(
                              children: [
                                Text("$des", style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Text("In $city", style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: EdgeInsets.all(35),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$temp", style: TextStyle(
                                  fontSize: 70,
                                ),),
                                Text("C", style: TextStyle(
                                  fontSize: 30,
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row( // 2 container banane k liye
                  mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.fromLTRB(25, 10, 10, 0),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.day_windy),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text("$wind",style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),),
                            Text("km/hr"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.fromLTRB(10, 10, 25, 0),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text("$hum",style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),),
                            Text("Percent"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100,), // to not get white screen in bottom
                Container(
                  padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Made by Yash"),
                    Text("Data Provided By Openweathermap.org")
                  ],
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
