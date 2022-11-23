class PlantaDB {
  int id;
  String projeto;
  String coletor;
  String estado;
  String municipio;
  DateTime data;

  PlantaDB();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
    };
    return map;
  }

  PlantaDB.fromMap(Map<String, dynamic> map) {
    id = map['id'];
  }
}
