import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../sqlite/coleta_db.dart';

class DBHelperColeta {
  static Database _db;
  static const String ID = 'id';
  static const String PROJETO = 'projeto';
  static const String COLETOR = 'coletor';
  static const String ESTADO = 'estado';
  static const String MUNICIPIO = 'municipio';
  static const String DATA = 'data';
  static const String TABLE = 'ColetaDB';
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
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $PROJETO TEXT, $COLETOR TEXT, $ESTADO TEXT, $MUNICIPIO TEXT, $DATA TEXT)");
  }

  Future<ColetaDB> save(ColetaDB coleta) async {
    var dbClient = await db;
   coleta.id = await dbClient.insert(TABLE, coleta.toMap());

    // await dbClient.transaction((txn) async {
    //   var query = "INSERT INTO $TABLE ($PROJETO, $COLETOR, $ESTADO) VALUES ('${coleta.projeto}', '${coleta.coletor}', '${coleta.projeto}' )";
    //   return await txn.rawInsert(query);
    // });
    return coleta;
  }

  Future<List<ColetaDB>> getColeta() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, PROJETO, COLETOR, ESTADO, MUNICIPIO, DATA]);
    // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<ColetaDB> coletas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        coletas.add(ColetaDB.fromMap(maps[i]));
      }
    }
    return coletas;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(ColetaDB coleta) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, coleta.toMap(),
        where: '$ID = ?', whereArgs: [coleta.id]);
  }

  Future close() async {
    var dbColeta = await db;
    dbColeta.close();
  }
}
