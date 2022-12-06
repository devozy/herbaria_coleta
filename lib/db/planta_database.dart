import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/helpers/helpers.dart';
import '../models/planta.dart';

class PlantaDatabase {
  static final PlantaDatabase instance = PlantaDatabase._init();
  static Database _database;

  PlantaDatabase._init();

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

    return await openDatabase(path, version: 1);
  }

  Future<Planta> save(final Planta planta) async {
    final db = await instance.database;
    final id = await db.insert(tablePlanta, planta.toMap());

    return planta.copy(id: id);
  }

  Future<Planta> findById(int id) async {
    final db = await instance.database;
    final maps = await db.query(tablePlanta,
        columns: PlantaFields.values,
        where: '${PlantaFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Planta.fromMap(maps.first);
    } else {
      throw Exception('Planta $id not found');
    }
  }

  Future<List<Planta>> findAll() async {
    final db = await instance.database;

    const orderBy = '${PlantaFields.id} DESC';
    final result = await db.query(tablePlanta, orderBy: orderBy);
    return result.map((e) => Planta.fromMap(e)).toList();
  }

  Future<int> update(Planta planta) async {
    findById(planta.id);
    final db = await instance.database;

    return db.update(tablePlanta, planta.toMap(),
        where: '${PlantaFields.id} = ?', whereArgs: [planta.id]);
  }

  Future<int> deleteById(int id) async {
    final db = await instance.database;

    return await db
        .delete(tablePlanta, where: '${PlantaFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
