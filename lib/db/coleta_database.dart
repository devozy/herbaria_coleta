import 'package:herbaria_coleta/models/coleta.dart';
import 'package:herbaria_coleta/models/helpers/helpers.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/planta.dart';

class ColetaDatabase {
  static final ColetaDatabase instance = ColetaDatabase._init();
  static Database _database;

  ColetaDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _init('herbaria.db');
    return _database;
  }

  Future<Database> _init(String name) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, name);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableColeta (
    ${ColetaFields.id} ${Helpers.idType},
    ${ColetaFields.projeto} ${Helpers.textType},
    ${ColetaFields.coletor} ${Helpers.textType},
    ${ColetaFields.estado} ${Helpers.textType},
    ${ColetaFields.municipio} ${Helpers.textType},
    ${ColetaFields.data} ${Helpers.textType}
    )
    ''');

    await db.execute('''
    CREATE TABLE $tablePlanta (
    ${PlantaFields.id} ${Helpers.idType},
    ${PlantaFields.numeroColeta} ${Helpers.intType},
    ${PlantaFields.familia} ${Helpers.textType},
    ${PlantaFields.genero} ${Helpers.textType},
    ${PlantaFields.epiteto} ${Helpers.textType},
    ${PlantaFields.altura} ${Helpers.textType},
    ${PlantaFields.flor} ${Helpers.textType},
    ${PlantaFields.fruto} ${Helpers.textType},
    ${PlantaFields.substrato} ${Helpers.textType},
    ${PlantaFields.ambiente} ${Helpers.textType},
    ${PlantaFields.relevo} ${Helpers.textType},
    ${PlantaFields.coordenada} ${Helpers.textType},
    ${PlantaFields.observacao} ${Helpers.textType},
    ${PlantaFields.coletaId} ${Helpers.intType}
    )
    ''');
  }

  Future<Coleta> save(final Coleta coleta) async {
    final db = await instance.database;
    final id = await db.insert(tableColeta, coleta.toMap());

    return coleta.copy(id: id);
  }

  Future<Coleta> findById(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableColeta,
        columns: ColetaFields.values,
        where: '${ColetaFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Coleta.fromMap(maps.first);
    } else {
      throw Exception('Coleta $id not found');
    }
  }

  Future<List<Coleta>> findAll() async {
    final db = await instance.database;

    const orderBy = '${ColetaFields.id} DESC';
    final result = await db.query(tableColeta, orderBy: orderBy);
    return result.map((e) => Coleta.fromMap(e)).toList();
  }

  Future<int> update(Coleta coleta) async {
    final db = await instance.database;

    return db.update(tableColeta, coleta.toMap(),
        where: '${ColetaFields.id} = ?', whereArgs: [coleta.id]);
  }

  Future<int> deleteById(int id) async {
    final db = await instance.database;

    return await db
        .delete(tableColeta, where: '${ColetaFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
