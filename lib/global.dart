import 'package:desafio_academy/repository/trip_repository.dart';

import 'database/database_helper.dart';

late final TripRepository tripRepository;

void initialize() {
  final db = DatabaseHelper();

  tripRepository = TripRepository(databaseHelper: db);
}