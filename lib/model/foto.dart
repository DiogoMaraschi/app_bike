import 'package:geolocator/geolocator.dart';

class Foto {
  final int? id;
  final String image_path;
  final DateTime data;
  final double long;
  final double lati;
  final int trip_id;

  Foto({
    this.id,
    required this.image_path,
    required this.data,
    required this.long,
    required this.lati,
    required this.trip_id,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'image_path': image_path,
      'data': data.toIso8601String(),
      'long': long,
      'lati': lati,
      'trip_id': trip_id,
    };
  }

  factory Foto.fromMap(Map<String, dynamic> map) {
    return Foto(
      id: map['id'],
      image_path: map['image_path'],
      data: DateTime.parse(map['data']),
      long: map['long'],
      lati: map['lati'],
      trip_id: map['trip_id'],
    );
  }
}
