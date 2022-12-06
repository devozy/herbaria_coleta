const String tablePlanta = 'Planta';

class PlantaFields {
  static const String id = '_id';
  static const String numeroColeta = 'numeroColeta';
  static const String familia = 'familia';
  static const String genero = 'genero';
  static const String epiteto = 'epiteto';
  static const String altura = 'altura';
  static const String flor = 'flor';
  static const String fruto = 'fruto';
  static const String substrato = 'substrato';
  static const String ambiente = 'ambiente';
  static const String relevo = 'relevo';
  static const String coordenada = 'coordenada';
  static const String observacao = 'observacao';
  static const String coletaId = '_coletaId';

  static List<String> values = [
    id,
    numeroColeta,
    familia,
    genero,
    epiteto,
    altura,
    flor,
    fruto,
    substrato,
    ambiente,
    relevo,
    coordenada,
    observacao,
    coletaId
  ];
}

class Planta {
  final int id;
  final int numeroColeta;
  final String familia;
  final String genero;
  final String epiteto;
  final String altura;
  final String flor;
  final String fruto;
  final String substrato;
  final String ambiente;
  final int relevo;
  final String coordenada;
  final String observacao;
  final int coletaId;

  const Planta({
    this.id,
    this.numeroColeta,
    this.familia,
    this.genero,
    this.epiteto,
    this.altura,
    this.flor,
    this.fruto,
    this.substrato,
    this.ambiente,
    this.relevo,
    this.coordenada,
    this.observacao,
    this.coletaId,
  });

  Map<String, Object> toMap() => {
        PlantaFields.id: id,
        PlantaFields.numeroColeta: numeroColeta,
        PlantaFields.familia: familia,
        PlantaFields.genero: genero,
        PlantaFields.epiteto: epiteto,
        PlantaFields.altura: altura,
        PlantaFields.flor: flor,
        PlantaFields.fruto: fruto,
        PlantaFields.substrato: substrato,
        PlantaFields.ambiente: ambiente,
        PlantaFields.relevo: relevo,
        PlantaFields.coordenada: coordenada,
        PlantaFields.observacao: observacao,
        PlantaFields.coletaId: coletaId,
      };

  Planta copy({
    int id,
    int numeroColeta,
    String familia,
    String genero,
    String epiteto,
    double altura,
    String flor,
    String fruto,
    String substrato,
    String ambiente,
    int relevo,
    String coordenada,
    String observacao,
    int coletaId,
  }) =>
      Planta(
        id: id ?? this.id,
        numeroColeta: numeroColeta ?? this.numeroColeta,
        familia: familia ?? this.familia,
        genero: genero ?? this.genero,
        epiteto: epiteto ?? this.epiteto,
        altura: altura ?? this.altura,
        flor: flor ?? this.flor,
        fruto: fruto ?? this.fruto,
        substrato: substrato ?? this.substrato,
        ambiente: ambiente ?? this.ambiente,
        relevo: relevo ?? this.relevo,
        coordenada: coordenada ?? this.coordenada,
        observacao: observacao ?? this.observacao,
        coletaId: coletaId ?? this.coletaId,
      );

  static Planta fromMap(Map<String, dynamic> map) => Planta(
        id: map[PlantaFields.id] as int,
        numeroColeta: map[PlantaFields.numeroColeta] as int,
        familia: map[PlantaFields.familia] as String,
        genero: map[PlantaFields.genero] as String,
        epiteto: map[PlantaFields.epiteto] as String,
        altura: map[PlantaFields.altura] as String,
        flor: map[PlantaFields.flor] as String,
        fruto: map[PlantaFields.fruto] as String,
        substrato: map[PlantaFields.substrato] as String,
        ambiente: map[PlantaFields.ambiente] as String,
        relevo: map[PlantaFields.relevo] as int,
        coordenada: map[PlantaFields.coordenada] as String,
        observacao: map[PlantaFields.observacao] as String,
        coletaId: map[PlantaFields.coletaId] as int,
      );
}
