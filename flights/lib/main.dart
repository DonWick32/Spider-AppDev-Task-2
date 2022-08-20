// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flights/flights.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';

String apiKey = "18a99f6601e958a423100c1534b741e3";

String? origin;
String? destination;
var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);

List<AirportsData> airportsData = [
  AirportsData("MAA", "Chennai"),
  AirportsData("DEL", "Delhi"),
  AirportsData("BOM", "Mumbai"),
  AirportsData("IXZ", "Port Blair"),
  AirportsData("TRZ", "Tiruchirappalli"),
  AirportsData("DXB", "Dubai"),
  AirportsData("DOH", "Doha"),
  AirportsData("LHR", "London"),
  AirportsData("MEX", "Mexico City"),
  AirportsData("SIN", "Singapore"),
  AirportsData("HKG", "Hong Kong"),
  AirportsData("IST", "Istanbul"),
  AirportsData("AUH", "Abu Dhabi"),
  AirportsData("FRA", "Frankfurt"),
  AirportsData("AMS", "Amsterdam"),
  AirportsData("ATL", "Atlanta"),
  AirportsData("JFK", "New York"),
  AirportsData("SYD", "Sydney"),
  AirportsData("LAX", "Los Angles"),
  AirportsData("YYZ", "Toronto")
];
List<String> airports = [
  "[MAA] - Chennai",
  "[DEL] - Delhi",
  "[BOM] - Mumbai",
  "[BLR] -  Bangalore",
  "[IXZ] - Port Blair",
  "[TRZ] - Tiruchirappalli",
  "[DXB] - Dubai",
  "[DOH] - Doha",
  "[LHR] - London",
  "[MEX] - Mexico City",
  "[SIN] - Singapore",
  "[HKG] - Hong Kong",
  "[IST] - Istanbul",
  "[AUH] - Abu Dhabi",
  "[FRA] - Frankfurt",
  "[AMS] - Amsterdam",
  "[ATL] - Atlanta",
  "[JFK] - New York",
  "[SYD] - Sydney",
  "[LAX] - Los Angeles",
  "[YYZ] - Toronto"
];
List<FlightsData> flightsData = [];

Future<List<String>> getAirportsData() async {
  var jsonData = await http.get(Uri.parse(
      "http://api.aviationstack.com/v1/airports?access_key=${apiKey}&offset=1400"));
  var data = jsonDecode(jsonData.body);

  for (var i in data["data"]) {
    if (!airports.contains("${"[" + i["iata_code"]}] - ${i["airport_name"]}") &&
        i["airport_name"].toString().length < 18) {
      airports.add("${"[" + i["iata_code"]}] - ${i["airport_name"]}");
      airportsData.add(AirportsData(i["iata_code"], i["airport_name"]));
    }
  }
  return airports;
}

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            child: Text(
              item,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );

String url =
    "http://api.aviationstack.com/v1/airports/access_key=57444420ca68204eb684156458898ef3";

class HomeState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Flights",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Text(
                  "From",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 96, 75, 255),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 158, 146, 248),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color.fromARGB(255, 158, 146, 248),
                    width: 3,
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Color.fromARGB(255, 158, 146, 248),
                  ),
                  child: FutureBuilder<List<String>>(
                    future: getAirportsData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              "Choose Origin",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            value: origin,
                            iconSize: 36,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            isExpanded: true,
                            items: airports.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              origin = value;
                            }),
                          ),
                        );
                      } else {
                        return Text(
                          "Loading...",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Text(
                  "To",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 96, 75, 255),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 158, 146, 248),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color.fromARGB(255, 158, 146, 248),
                    width: 3,
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Color.fromARGB(255, 158, 146, 248),
                  ),
                  child: FutureBuilder<List<String>>(
                    future: getAirportsData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              "Choose Destination",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            value: destination,
                            iconSize: 36,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            isExpanded: true,
                            items: airports.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              destination = value;
                            }),
                          ),
                        );
                      } else {
                        return Text(
                          "Loading...",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                height: 100,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: SizedBox(
                  width: 150,
                  height: 75,
                  child: ElevatedButton(
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    onPressed: () async {
                      if (origin != destination && airports.contains(origin) && airports.contains(destination)) {
                      flightsData = [];
                      var jsonData = await http.get(Uri.parse(
                          "http://api.aviationstack.com/v1/flights?access_key=${apiKey}&dep_iata=${origin![1] + origin![2] + origin![3]}&arr_iata=${destination![1] + destination![2] + destination![3]}"));
                      if (jsonData.statusCode != 200) {
                        Fluttertoast.showToast(
                                      msg: "No flights found!",
                                      fontSize: 15,
                                    );
                      }
                      else {
                      var data = jsonDecode(jsonData.body);
                      if (data != null) {
                        for (var i in data["data"]) {
                          if (i["flight_date"] == formattedDate) {
                            String dep = DateTime.parse(i["departure"]
                                            ["scheduled"]
                                        .replaceAll("T", " ")
                                        .replaceAll("+00:00", ".000"))
                                    .hour
                                    .toString() +
                                ":" +
                                DateTime.parse(i["departure"]["scheduled"]
                                        .replaceAll("T", " ")
                                        .replaceAll("+00:00", ".000"))
                                    .minute
                                    .toString() +
                                " hrs";
                            String arr = DateTime.parse(i["arrival"]
                                            ["scheduled"]
                                        .replaceAll("T", " ")
                                        .replaceAll("+00:00", ".000"))
                                    .hour
                                    .toString() +
                                ":" +
                                DateTime.parse(i["arrival"]["scheduled"]
                                        .replaceAll("T", " ")
                                        .replaceAll("+00:00", ".000"))
                                    .minute
                                    .toString() +
                                " hrs";
                            flightsData.add(FlightsData(
                                i["flight_date"],
                                dep,
                                arr,
                                i["airline"]["name"],
                                i["flight"]["iata"]));
                          }
                        }
                      }
                      }
                      if (flightsData.length != 0){
                      setState(() {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                flights(flightsData, origin!, destination!)));
                      });}
                      else {
                        Fluttertoast.showToast(
                                      msg: "No flight found.",
                                      fontSize: 15,
                                    );
                      }
                    }
                    else if (!airports.contains(origin) || !airports.contains(destination)){
                      
                      Fluttertoast.showToast(
                                      msg: "Pick Origin and Destination.",
                                      fontSize: 15,
                                    );
                    }
                    else {
                      Fluttertoast.showToast(
                                      msg: "Origin and Destination must be different.",
                                      fontSize: 15,
                                    );
                    }
                    
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AirportsData {
  final String iata_code;
  final String airport_name;

  AirportsData(this.iata_code, this.airport_name);
}

class FlightsData {
  final String flight_date;
  final String depTime;
  final String arrTime;
  final String airline;
  final String flightCode;

  FlightsData(this.flight_date, this.depTime, this.arrTime, this.airline,
      this.flightCode);
}
