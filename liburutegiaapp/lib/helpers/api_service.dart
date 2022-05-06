import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:liburutegiaapp/models/eskaera.dart';
import 'package:liburutegiaapp/models/eskaera_lerroa.dart';
import 'package:liburutegiaapp/models/idazlea.dart';
import 'package:liburutegiaapp/models/liburua.dart';
import 'package:liburutegiaapp/helpers/globals.dart' as globals;

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
    book.sort((a, b) => a.izenburua.compareTo(b.izenburua));
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
    idazleak.sort((a, b) => a.izena.compareTo(b.izena));
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
      throw Exception('Failed to login');
    }
  }

  Future<int> signup(SignupData s) async {
    Uri url = Uri.parse(baseUrl + "/signup");

    final response = await http.post(url,
        body: {"email": s.name, "password": s.password},
        headers: {"Access-Control-Allow-Origin": "*"});
    if (response.statusCode == 201 || response.statusCode == 409) {
      return response.statusCode;
    } else {
      throw Exception('Failed to signup');
    }
  }

  Future<int> getErabiltzaileId(String erab) async {
    Uri url = Uri.parse(baseUrl + "/login/" + erab);
    final response =
        await http.get(url, headers: {"Access-Control-Allow-Origin": "*"});

    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      return map[0]["idErabiltzailea"];
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<bool> eskatu(Eskaera e) async {
    Uri url = Uri.parse(baseUrl + "/eskaerak");

    e.idErabiltzailea = await getErabiltzaileId(globals.username);
    final response = await http.post(url, body: jsonEncode(e), headers: {
      "Access-Control-Allow-Origin": "*",
      "content-type": "application/json"
    });
    if (response.statusCode == 201) {
      return response.body == "true";
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<Eskaera>> getEskaerakByErabiltzailea(String erab) async {
    int id = await getErabiltzaileId(erab);
    Uri url = Uri.parse(baseUrl + "/eskaerak/" + id.toString());
    final response =
        await http.get(url, headers: {"Access-Control-Allow-Origin": "*"});

    if (response.statusCode == 200) {
      List<Eskaera> eskaerak = (json.decode(response.body) as List)
          .map((i) => Eskaera.fromJson(i))
          .toList();

      for (Eskaera e in eskaerak) {
        e.eskaeraData = e.eskaeraData.add(const Duration(days: 1));
        e.itzultzeData = e.itzultzeData.add(const Duration(days: 1));
        e.lerroak = <EskaeraLerroa>[];
        e.lerroak = await getLerroakByEskaera(e.idEskaera!);
      }
      eskaerak.sort(((a, b) => b.eskaeraData.compareTo(a.eskaeraData)));
      return eskaerak;
    } else {
      throw Exception('Failed to load eskaerak');
    }
  }

  Future<List<EskaeraLerroa>> getLerroakByEskaera(int idEskaera) async {
    Uri url =
        Uri.parse(baseUrl + "/eskaerak/" + idEskaera.toString() + "/lerroak");
    final response =
        await http.get(url, headers: {"Access-Control-Allow-Origin": "*"});
    if (response.statusCode == 200) {
      List<Liburua> liburuak = await getLiburuakIdazlearekin();
      List<EskaeraLerroa> lerroak = (json.decode(response.body) as List)
          .map((i) => EskaeraLerroa.fromJson(i))
          .toList();

      for (var l in lerroak) {
        l.liburua =
            liburuak.firstWhere((element) => element.idLiburua == l.idLiburua);
      }
      return lerroak;
    } else {
      throw Exception('Failed to load eskaerak');
    }
  }

  Future<bool> itzuli(EskaeraLerroa l) async {
    Uri url =
        Uri.parse(baseUrl + "/eskaerak/" + l.idEskaera.toString() + "/lerroak");
    final response = await http.post(url,
        body: {"idLerroa": l.idEskaeraLerroa.toString()},
        headers: {"Access-Control-Allow-Origin": "*"});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update');
    }
  }
}
