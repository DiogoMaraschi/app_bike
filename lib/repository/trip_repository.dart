import 'package:desafio_academy/database/database_helper.dart';
import 'package:desafio_academy/model/trip.dart';

class TripRepository {
  final DatabaseHelper databaseHelper;

  TripRepository({required this.databaseHelper});

  static const String tableName = 'trip';

  Future<void> inserir(Trip trip) async{
    final conn = await databaseHelper.database;

    conn.insert(tableName, trip.toMap());
  }

  Future<List<Trip>> buscar() async{
    final conn = await databaseHelper.database;

    final result = await conn.query(tableName);
    return result.map((map) => Trip.fromMap(map)).toList();
  }
}