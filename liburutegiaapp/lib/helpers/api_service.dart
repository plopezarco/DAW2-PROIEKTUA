import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:liburutegiaapp/models/idazlea.dart';
import 'package:liburutegiaapp/models/liburua.dart';

class ApiService {
  static String baseUrl =
      kIsWeb ? "http://localhost:8081" : "http://10.0.2.2:8081";

  Future<List<Liburua>> getLiburuak() async {
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

  Future<List<Liburua>> getLiburuakByIdazlea(String id) async {
    Uri url = Uri.parse(baseUrl + "/liburuak/idazlea/" + id);
    final response =
        await http.get(url, headers: {"Access-Control-Allow-Origin": "*"});

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => Liburua.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Liburua>> getLiburuakIdazlearekin() async {
    List<Liburua> book = await getLiburuak();
    for (Liburua l in book) {
      l.idazlea = await getIdazleaById(l.idIdazlea.toString());
    }
    return book;
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

  Future<List<Idazlea>> getIdazleakLiburuekin() async {
    List<Idazlea> idazleak = await getIdazleak();
    for (Idazlea i in idazleak) {
      i.liburuak = await getLiburuakByIdazlea(i.idIdazlea.toString());
    }
    return idazleak;
  }

  Future<Idazlea> getIdazleaById(String id) async {
    Uri url = Uri.parse(baseUrl + "/idazleak/" + id);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => Idazlea.fromJson(i))
          .first;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<bool> login(LoginData l) async {
    try {
      Uri url = Uri.parse(baseUrl + "/login/");

      final response = await http.post(url,
          body: {"email": l.name, "password": l.password},
          headers: {"Access-Control-Allow-Origin": "*"});
      if (response.statusCode == 200) {
        return response.body == "true";
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to login');
    }
  }
}
