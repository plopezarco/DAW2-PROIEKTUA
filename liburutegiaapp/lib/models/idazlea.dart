class Idazlea {
  final int idIdazlea;
  final String izena;
  final String biografia;
  final String irudia;

  Idazlea(this.idIdazlea, this.izena, this.biografia, this.irudia);

  factory Idazlea.fromJson(Map<String, dynamic> json) {
    return Idazlea(json["idIdazlea"] ?? 0, json["Izena"] ?? "",
        json["Biografia"] ?? "", json["Irudia"] ?? "");
  }
}
