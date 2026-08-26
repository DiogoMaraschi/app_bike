import 'package:desafio_academy/repository/foto_repository.dart';
import 'package:desafio_academy/repository/trip_repository.dart';

import 'database/database_helper.dart';

late final TripRepository tripRepository;
late final FotoRepository fotoRepository;

void initialize() {
  final db = DatabaseHelper();

  tripRepository = TripRepository(databaseHelper: db);
  fotoRepository = FotoRepository(databaseHelper: db);
}
