class Liburua {
  final int idLiburua;
  final String isbn;
  final String izenburua;
  final int orriKopurua;
  final String generoa;
  final int urtea;
  final String irudia;
  final int stock;

  Liburua(this.idLiburua, this.isbn, this.izenburua, this.orriKopurua,
      this.generoa, this.urtea, this.irudia, this.stock);

  factory Liburua.fromJson(Map<String, dynamic> json) {
    return Liburua(
        json["idLiburua"] ?? 0,
        json["ISBN"] ?? "",
        json["Izenburua"] ?? "",
        json["OrriKopurua"] ?? 0,
        json["Generoa"] ?? "",
        json["Urtea"] ?? 0,
        json["Irudia"] ?? "",
        json["Stock"] ?? 0);
  }
}
