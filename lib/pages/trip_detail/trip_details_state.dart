import 'package:desafio_academy/global.dart';
import 'package:desafio_academy/model/trip.dart';
import 'package:desafio_academy/service/camera.dart';
import 'package:desafio_academy/service/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:desafio_academy/model/foto.dart';
import 'package:geolocator/geolocator.dart';

class TripDetailsState extends ChangeNotifier {
  final int id;

  List<Foto> _fotos = [];

  List<Foto> get getFotos => _fotos;

  TripDetailsState({required this.id});

  Trip? _trip;

  Trip? get trip => _trip;

  Future<void> carregarTrip() async {
    print('Buscando Trip ID: $id');

    _trip = await tripRepository.buscarPorId(id);

    print('Trip encontrada: $_trip');

    notifyListeners();
  }

  Future<void> carregarFotos() async {
    _fotos = await fotoRepository.buscarPorTrip(id);

    notifyListeners();
  }

  Future<void> criarTrip(Trip trip) async {
    await tripRepository.inserir(trip);

    notifyListeners();
  }

  Future<String?> tirarFoto() async {
    return await Camera().captureImage();
  }

  Future<Position?> obterPosicao() async {
    return await Geolocation().getCurrentPosition();
  }

  Future<void> salvarNota() async {
    final path = await tirarFoto();
    final position = await obterPosicao();
    final foto = Foto(
      image_path: path!,
      data: DateTime.now(),
      long: position!.longitude,
      lati: position.latitude,
      trip_id: trip!.id!,
    );
    fotoRepository.salvar(foto);
  }
}
