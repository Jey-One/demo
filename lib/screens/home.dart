import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taller/models/data.dart';
import 'package:taller/services/api_service.dart';
import 'package:taller/services/shared_preference_service.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Data _data = Data();
  @override
  void initState() {
    initData();
  }

  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  }

  Future<void> initData() async {
    ApiService apiService = ApiService();
    SharedPreferenceService sharedPreferenceService = SharedPreferenceService();

    await requestPermission();
    String key = buildKeyFechaActual();

    String? value = await sharedPreferenceService.getData(key);
    if (value != null) {
      _data = Data.fromJson(json.decode(value));
    } else {
      Position geolocator = await Geolocator.getCurrentPosition();
      _data = await apiService.getData(
          geolocator.latitude.toString(), geolocator.longitude.toString());
      _data = getDataDura();
      sharedPreferenceService.setData(key, json.encode(_data.toMap()));
    }
    setState(() {});
  }

  Data getDataDura() {
    Data data = Data();
    data.highestUvOfTheDay = '11 - 12:18PM';
    data.rangeOfHoursWithUv = '03:00 - 05:00';
    data.temperature = '25°';
    data.uv = '9';
    data.hour = '03:00 PM';
    return data;
  }

  String buildKeyFechaActual() {
    DateTime now = DateTime.now();
    return '${now.year}${now.month}${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Highest UV of the day    ${_data.highestUvOfTheDay}'),
            Text('Range of hours with UV   ${_data.rangeOfHoursWithUv}'),
            Text('Temperature              ${_data.temperature}'),
            Text('UV                       ${_data.uv}'),
            Text('Hour                     ${_data.hour}'),
          ],
        ),
      ),
    );
  }
}
