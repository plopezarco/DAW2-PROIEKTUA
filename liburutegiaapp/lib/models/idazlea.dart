import 'package:liburutegiaapp/models/liburua.dart';

class Idazlea {
  int idIdazlea;
  String izena;
  String biografia;
  String irudia;
  late List<Liburua> liburuak;

  Idazlea(this.idIdazlea, this.izena, this.biografia, this.irudia);

  factory Idazlea.fromJson(Map<String, dynamic> json) {
    return Idazlea(json["idIdazlea"] ?? 0, json["Izena"] ?? "",
        json["Biografia"] ?? "", json["Irudia"] ?? "");
  }
}
