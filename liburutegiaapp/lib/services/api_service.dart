import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:liburutegiaapp/models/idazlea.dart';
import 'package:liburutegiaapp/models/liburua.dart';

class ApiService {
  static String baseUrl = "http://10.0.2.2:8081";

  Future<List<Liburua>> getBooks() async {
    Uri url = Uri.parse(baseUrl + "/liburuak");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => Liburua.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Idazlea>> getIdazleak() async {
    Uri url = Uri.parse(baseUrl + "/idazleak");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => Idazlea.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
