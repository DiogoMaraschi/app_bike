import 'package:desafio_academy/main.dart';
import 'package:desafio_academy/model/trip.dart';
import 'package:desafio_academy/repository/trip_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../global.dart';

class TripListState with ChangeNotifier {


  TripListState();

  final List<Trip> _trips = [];

  List<Trip> get getList {
    return _trips;
  }

  Future<List<Trip>> carregarLista() async {
    await inserir();
    final list = await tripRepository.buscar();
    _trips
      ..clear()
      ..addAll(list);
    notifyListeners();
    return _trips;
  }
  
  Future<void> inserir()async{
    await tripRepository.inserir(Trip(dataInicio: DateTime(2000), dataFim: DateTime(2000)));
    await tripRepository.inserir(Trip(dataInicio: DateTime(2000), dataFim: DateTime(2000)));
    await tripRepository.inserir(Trip(dataInicio: DateTime(2000), dataFim: DateTime(2000)));
    await tripRepository.inserir(Trip(dataInicio: DateTime(2000), dataFim: DateTime(2000)));
    await tripRepository.inserir(Trip(dataInicio: DateTime(2000), dataFim: DateTime(2000)));

  }
}
