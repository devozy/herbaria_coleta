import 'package:herbaria_coleta/models/coleta.dart';
import 'package:herbaria_coleta/models/helpers/helpers.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HerbariaDatabase {
  static final HerbariaDatabase instance = HerbariaDatabase._init();
  static Database _database;

  HerbariaDatabase._init();

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
