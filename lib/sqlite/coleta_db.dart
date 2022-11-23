import 'package:herbaria_coleta/sqlite/planta_db.dart';

class ColetaDB {
  int id;
  String projeto;
  String coletor;
  String estado;
  String municipio;
  String data;
  //PlantaDB planta;

  ColetaDB(this.id, this.projeto, this.coletor, this.estado, this.municipio, this.data);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'projeto': projeto,
      'coletor': coletor,
      'estado': estado,
      'municipio': municipio,
      'data': data,
    };
    return map;
  }

  ColetaDB.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    projeto = map['projeto'];
    coletor = map['coletor'];
    estado = map['estado'];
    municipio = map['municipio'];
    data = map['data'];
  }
}
