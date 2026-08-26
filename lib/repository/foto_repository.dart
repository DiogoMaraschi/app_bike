import 'package:desafio_academy/database/database_helper.dart';
import 'package:desafio_academy/model/foto.dart';

class FotoRepository {
  final DatabaseHelper databaseHelper;

  FotoRepository({required this.databaseHelper});

  static const tableName = 'foto';

  Future<void> salvar(Foto foto) async {
    final conn = await databaseHelper.database;
    conn.insert(tableName, foto.toMap());
  }

  Future<List<Foto>> buscarPorTrip(int tripId) async {
    final conn = await databaseHelper.database;

    final result = await conn.query(
      'foto',
      where: 'trip_id = ?',
      whereArgs: [tripId],
    );

    return result.map((map) => Foto.fromMap(map)).toList();
  }
}
