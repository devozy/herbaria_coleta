import 'dart:async';
import 'dart:io' as io;
import 'package:herbaria_coleta/sqlite/planta_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../form_page/planta_page.dart';

class DBHelperPlanta {
  String id_Coleta;

  DBHelperPlanta(int cur_coletaId) {
    id_Coleta = cur_coletaId.toString();
  }

  String nomeTabela;

  static Database _db;
  static const String ID = 'id';
  static const String NUMERO_COLETA = 'numeroColeta';
  static const String FAMILIA = 'familia';
  static const String GENERO = 'genero';
  static const String EPITETO = 'epiteto';
  static const String ALTURA = 'altura';
  static const String FLOR = 'flor';
  static const String FRUTO = 'fruto';
  static const String SUBSTRATO = 'substrato';
  static const String AMBIENTE = 'ambiente';
  static const String COORDENADA = 'coordenada';
  static const String RELEVO = 'relevo';
  static const String OBSERVACAO = 'obervacao';
  static const String ID_COLETA = 'idColeta';
  static const String TABLE = 'coletaX';
  static const String DB_NAME = 'coleta1.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $nomeTabela ($ID INTEGER PRIMARY KEY, $NUMERO_COLETA TEXT, $FAMILIA TEXT, $GENERO TEXT, $EPITETO TEXT, $ALTURA TEXT, $FLOR TEXT, $FRUTO TEXT, $SUBSTRATO TEXT, $AMBIENTE TEXT, $RELEVO TEXT, $COORDENADA TEXT, $OBSERVACAO TEXT, $ID_COLETA TEXT  )");
  }

  Future<PlantaDB> save(PlantaDB planta) async {
    var dbClient = await db;
    planta.id = await dbClient.insert(nomeTabela, planta.toMap());
    return planta;
  }

  Future<List<PlantaDB>> getPlanta() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM $nomeTabela WHERE ID_COLETA = $id_Coleta");
    List<PlantaDB> plantas = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        plantas.add(PlantaDB.fromMap(maps[i]));
      }
    }
    return plantas;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(nomeTabela, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(PlantaDB planta) async {
    var dbClient = await db;
    return await dbClient.update(nomeTabela, planta.toMap(),
        where: '$ID = ?', whereArgs: [planta.id]);
  }

  Future close() async {
    var dbPlanta = await db;
    dbPlanta.close();
  }
}
