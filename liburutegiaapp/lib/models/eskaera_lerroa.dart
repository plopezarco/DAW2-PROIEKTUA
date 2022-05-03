import 'package:liburutegiaapp/models/liburua.dart';

class EskaeraLerroa {
  int idEskaera;
  int idLiburua;
  int idEskaeraLerroa;
  bool itzulita;
  Liburua? liburua;
  DateTime? itzultzeko;

  EskaeraLerroa(
      this.idEskaera, this.idEskaeraLerroa, this.idLiburua, this.itzulita);

  factory EskaeraLerroa.fromJson(Map<String, dynamic> json) {
    return EskaeraLerroa(json["idEskaera"] ?? 0, json["idEskaeralerroa"] ?? 0,
        json["idLiburua"] ?? 0, json["itzulita"] == 1);
  }
}
