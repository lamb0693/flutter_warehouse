import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

class GeolocatorPage extends StatefulWidget {
  const GeolocatorPage({super.key});

  @override
  State<GeolocatorPage> createState() => _GeolocatorPageState();
}

class _GeolocatorPageState extends State<GeolocatorPage> {
  late Position position;
  //final String apikey = ;

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> getWeatherData() async {
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) return '{"error": "permission denied"}';
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      String msg = '경도 :${position.longitude}  위도 :${position.latitude}';
      Fluttertoast.showToast(
        msg: msg,
        fontSize: 30.0,
        backgroundColor: Colors.cyanAccent,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
      var url = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', {
        'lat': '${position.latitude}',
        'lon': '${position.longitude}',
        //'appid': apikey
      });

      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
        //print(jsonResponse);
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}.');
          return '{"error": "response : ${response.statusCode}"}';
        }
      }

    } catch (err) {
      print(err);
      return '{"error": "response : $err"}';
    }
    return '{"error": "contact to developer"}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator test'),
        backgroundColor: Colors.amber,
      ),
      body : Center(
        child: Column(
          children: [
            const SizedBox(
                height: 20.0,
            ),
            ButtonTheme(
              buttonColor: Colors.indigo[100],
              hoverColor: Colors.indigo[500],
              child: ElevatedButton(
                  onPressed: () async {
                    getWeatherData();
                  },
                  child: const Text('현재 날씨 가져 오기'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            FutureBuilder(
                future: getWeatherData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    print(snapshot.data);
                    if(jsonDecode(snapshot.data)['error'] != null){
                      return Text(jsonDecode(snapshot.data)['error']);
                    }else {
                      double temp = jsonDecode(snapshot.data)['main']['temp'];
                      temp -= 273.15;
                      return Column(
                        children: [
                          Text(jsonDecode(snapshot.data)['weather'][0]['description'],
                            style: const TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          Text(temp.round().toString(),
                            style: const TextStyle(
                              fontSize: 40,
                            ),),
                          Text(jsonDecode(snapshot.data)['name'],
                            style: const TextStyle(
                              fontSize: 40,
                            ),),
                        ],
                      );
                    }
                  }
                  return const CircularProgressIndicator();
                }
            )
          ],
        ),
      )
    );
  }
}
