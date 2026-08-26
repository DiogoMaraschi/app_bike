import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String databaseName = 'bicicleta.db';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await openDatabase(
      databaseName,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE trip (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      dataInicio TEXT NOT NULL,
      dataFim TEXT,
      local TEXT NOT NULL
      )
      ''');

        await db.execute('''
      CREATE TABLE foto (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      image_path TEXT NOT NULL,
      data TEXT NOT NULL,
      lati DECIMAL NOT NULL,
      long DECIMAL NOT NULL,
      trip_id INTEGER NOT NULL,
      FOREIGN KEY (trip_id) REFERENCES trip(id)
      )
      ''');
      },
    );
    return _database!;
  }

  Future<void> inserir(String tableName, Map<String, dynamic> dados) async {
    final db = await database;
    db.insert(tableName, dados);
  }

  Future<List<Map<String, dynamic>>> buscar(String tableName) async {
    final db = await database;
    return await db.query(tableName);
  }

  Future<void> apagarBanco() async {
    final caminho = await getDatabasesPath();

    await deleteDatabase('$caminho/$databaseName');

    _database = null;
  }
}
