import 'package:desafio_academy/model/trip.dart';
import 'package:flutter/cupertino.dart';

import '../../global.dart';

class TripListState with ChangeNotifier {
  TripListState();

  final List<Trip> _trips = [];

  List<Trip> get getList {
    return _trips;
  }

  Future<List<Trip>> carregarLista() async {
    final list = await tripRepository.buscar();
    _trips
      ..clear()
      ..addAll(list);
    notifyListeners();
    return _trips;
  }

  Future<int> inserir(String local) async {
    return await tripRepository.inserir(
      Trip(dataInicio: DateTime.now(), local: local),
    );
  }
}
