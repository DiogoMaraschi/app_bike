import 'package:desafio_academy/database/database_helper.dart';
import 'package:desafio_academy/model/trip.dart';

class TripRepository {
  final DatabaseHelper databaseHelper;

  TripRepository({required this.databaseHelper});

  static const String tableName = 'trip';

  Future<int> inserir(Trip trip) async {
    final conn = await databaseHelper.database;

    return conn.insert(tableName, trip.toMap());
  }

  Future<List<Trip>> buscar() async {
    final conn = await databaseHelper.database;

    final result = await conn.query(tableName);
    return result.map((map) => Trip.fromMap(map)).toList();
  }

  Future<Trip?> buscarPorId(int id) async {
    final conn = await databaseHelper.database;

    final result = await conn.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return Trip.fromMap(result.first);
  }

  Future<void> finalizarTrip(int id, DateTime datafim) async {
    final conn = await databaseHelper.database;

    await conn.update(
      tableName,
      {'dataFim': datafim.toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
