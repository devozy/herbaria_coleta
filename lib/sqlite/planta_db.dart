class PlantaDB {
  int id;
  int numeroColeta;
  String familia;
  String genero;
  String epiteto;
  double altura;
  String flor;
  String fruto;
  String substrato;
  String ambiente;
  int relevo;
  String coordenada;
  String observacao;
  int idColeta;

  PlantaDB(this.id, this.numeroColeta, this.familia, this.genero, this.epiteto, this.altura, this.flor, this.fruto, this.substrato, this.ambiente, this.relevo, this.coordenada, this.observacao, this.idColeta);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'numeroColeta': numeroColeta,
      'familia': familia,
      'genero': genero,
      'epiteto': epiteto,
      'altura': altura,
      'flor': flor,
      'fruto': fruto,
      'substrato': substrato,
      'ambiente': ambiente,
      'relevo': relevo,
      'coordenada': coordenada,
      'observacao': observacao,
      'idColeta': idColeta,

    };
    return map;
  }

  PlantaDB.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    numeroColeta = map['numeroColeta'];
    familia = map['familia'];
    genero = map['genero'];
    epiteto = map['epiteto'];
    altura = map['altura'];
    flor = map['flor'];
    fruto = map['fruto'];
    substrato = map['substrato'];
    ambiente = map['ambiente'];
    relevo = map['relevo'];
    coordenada = map['coordenada'];
    observacao = map['observacao'];
    idColeta = map['idColeta'];
  }
}
