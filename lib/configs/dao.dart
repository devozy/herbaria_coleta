import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../helpers/constants_helpers.dart';

class Dao {
  Database _database;

  Dao() {
    _database = initDb();
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path =
    join(documentsDirectory.path, ConstantsHelpers.DATA_BASE_NAME);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE ${ConstantsHelpers.TAB_PLANTA} ( ${ConstantsHelpers
            .ID} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ${ConstantsHelpers
            .NUMERO_COLETA} TEXT (255), ${ConstantsHelpers
            .FAMILIA} TEXT (255), ${ConstantsHelpers
            .GENERO} TEXT (255), ${ConstantsHelpers
            .EPITETO} TEXT (255), ${ConstantsHelpers
            .ALTURA} TEXT (255), ${ConstantsHelpers
            .FLOR} TEXT (255), ${ConstantsHelpers
            .FRUTO} TEXT (255), ${ConstantsHelpers
            .SUBSTRATO} TEXT (255), ${ConstantsHelpers
            .AMBIENTE} TEXT (255), ${ConstantsHelpers
            .COORDENADA} TEXT (255), ${ConstantsHelpers
            .RELEVO} TEXT (255), ${ConstantsHelpers
            .OBSERVACAO} TEXT (255), ${ConstantsHelpers
            .ID_COLETA} INTEGER NOT NULL)");
    await database.execute(
        "CREATE TABLE ${ConstantsHelpers.TAB_COLETA} (${ConstantsHelpers
            .ID} INTEGER PRIMARY KEY, ${ConstantsHelpers
            .PROJETO} TEXT, ${ConstantsHelpers.COLETOR} TEXT, ${ConstantsHelpers
            .ESTADO} TEXT, ${ConstantsHelpers
            .MUNICIPIO} TEXT, ${ConstantsHelpers.DATA} TEXT)");
  }

  Future<List<Map<String, dynamic>>> search(final String table,
      List<String> columns, String where) async {
    return await _database.query(table, columns: columns, where: where);
  }

  Future<int> insert(final String table, Map<String, dynamic> values) async {
    return await _database.insert(table, values);
  }
}
