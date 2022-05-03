import 'package:liburutegiaapp/models/eskaera_lerroa.dart';

class Eskaera {
  int? idEskaera;
  DateTime eskaeraData;
  DateTime itzultzeData;
  int? idErabiltzailea;
  String izena;
  String abizena;
  String helbidea;
  List<int>? idLiburuak;
  List<EskaeraLerroa>? lerroak;

  Eskaera(this.eskaeraData, this.itzultzeData, this.izena, this.abizena,
      this.helbidea);

  Map<String, dynamic> toJson() {
    return {
      "eskaeraData": eskaeraData.toIso8601String(),
      "itzultzeData": itzultzeData.toIso8601String(),
      "idErabiltzailea": idErabiltzailea ?? 1,
      "izena": izena,
      "abizena": abizena,
      "helbidea": helbidea,
      "liburuak": idLiburuak
    };
  }

  factory Eskaera.fromJson(Map<String, dynamic> json) {
    Eskaera e = Eskaera(
        DateTime.parse(json["EskaeraData"].toString()),
        DateTime.parse(json["ItzultzeData"].toString()),
        json["izena"],
        json["abizena"],
        json["helbidea"]);
    e.idEskaera = json["idEskaera"];
    return e;
  }
}
