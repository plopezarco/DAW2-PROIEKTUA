import 'package:liburutegiaapp/models/idazlea.dart';

class Liburua {
  int idLiburua;
  String isbn;
  String izenburua;
  String sinopsia;
  int orriKopurua;
  String generoa;
  int urtea;
  String irudia;
  int idIdazlea;
  Idazlea? idazlea;

  Liburua(this.idLiburua, this.isbn, this.izenburua, this.sinopsia,
      this.orriKopurua, this.generoa, this.urtea, this.irudia, this.idIdazlea);

  factory Liburua.fromJson(Map<String, dynamic> json) {
    return Liburua(
        json["idLiburua"] ?? 0,
        json["ISBN"] ?? "",
        json["Izenburua"] ?? "",
        json["Sinopsia"] ?? "",
        json["OrriKopurua"] ?? 0,
        json["Generoa"] ?? "",
        json["Urtea"] ?? 0,
        json["Irudia"] ?? "",
        json["idIdazlea"] ?? 0);
  }
}
