import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taller/models/data.dart';
import 'package:taller/util/constantes.dart';

class ApiService {
  Future<Data> getData(String lat, String lon) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/onecall',
        {'lat': lat, 'lon': lon, 'appid': apiKey});

    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Data.fromJson(jsonResponse);
    } else {
      //TODO ERROR
      return null!;
    }
  }
}
