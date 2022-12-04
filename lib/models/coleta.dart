const String tableColeta = 'coleta';

class ColetaFields {
  static const String id = '_id';
  static const String projeto = 'projeto';
  static const String coletor = 'coletor';
  static const String estado = 'estado';
  static const String municipio = 'municipio';
  static const String data = 'data';

  static List<String> values = [id, projeto, coletor, estado, municipio, data];
}

class Coleta {
  final int id;
  final String projeto;
  final String coletor;
  final String estado;
  final String municipio;
  final String data;

  const Coleta({
    this.id,
    this.projeto,
    this.coletor,
    this.estado,
    this.municipio,
    this.data,
  });

  Map<String, Object> toMap() => {
        ColetaFields.id: id,
        ColetaFields.projeto: projeto,
        ColetaFields.coletor: coletor,
        ColetaFields.estado: estado,
        ColetaFields.municipio: municipio,
        ColetaFields.data: data,
      };

  Coleta copy({
    int id,
    String projeto,
    String coletor,
    String estado,
    String municipio,
    String data,
  }) =>
      Coleta(
          id: id ?? this.id,
          projeto: projeto ?? this.projeto,
          coletor: coletor ?? this.coletor,
          estado: estado ?? this.estado,
          municipio: municipio ?? this.municipio,
          data: data ?? this.data);

  static Coleta fromMap(Map<String, dynamic> map) => Coleta(
        id: map[ColetaFields.id] as int,
        projeto: map[ColetaFields.projeto] as String,
        coletor: map[ColetaFields.coletor] as String,
        estado: map[ColetaFields.estado] as String,
        municipio: map[ColetaFields.municipio] as String,
        data: map[ColetaFields.data] as String,
      );
}
