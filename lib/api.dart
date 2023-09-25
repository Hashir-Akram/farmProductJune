import 'dart:convert';
import 'package:faramproduct/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  // Data
  Map<String, dynamic> _weatherData = {};
  int lat = 29;
  int long = 77;
  bool showImage = false;
  bool searchPressed = false;

  // Fetch data from the API
  Future<void> fetchData() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast( // Display toast message for no internet connection
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _weatherData = jsonData;
          showImage = true;
          searchPressed = true;
          _weatherData['error'] = null; // Clear the error message
        });
      } else {
        showError("Failed to load data");
      }
    } catch (error) {
      showError("An error occurred: $error");
    }
  }

  // Show error message
  void showError(String message) {
    setState(() {
      _weatherData = {'error': message};
      showImage = false;
      searchPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Weather API"),
        backgroundColor: Colors.blue,
      ),
      drawer: appDrawer(context),
      body: _buildBody(),
    );
  }

  // Build the main body of the app
  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.cyan],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Weather API",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Latitude: ${_weatherData['latitude']}",
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Longitude: ${_weatherData['longitude']}",
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              if (searchPressed) const SizedBox(height: 30),
              Visibility(
                visible: searchPressed,
                child: Container(
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Colors.cyan],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _weatherData.isNotEmpty
                            ? "${_weatherData['current_weather']['temperature']} °C"
                            : "Temperature: null",
                        style: TextStyle(
                          fontSize: searchPressed ? 45 : 30,
                          color: Colors.black,
                          fontWeight: searchPressed
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                          image: const DecorationImage(
                            image:
                            AssetImage('assets/images/partly_cloudy.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: searchPressed,
                            child: const Icon(
                              Icons.air,
                              size: 30,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            _weatherData.isNotEmpty
                                ? "${_weatherData['current_weather']['windspeed']} km/h"
                                : "Wind-Speed: null",
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: fetchData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    child: Text(
                      "Search",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
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
