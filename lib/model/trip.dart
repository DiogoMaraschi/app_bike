class Trip {
  final int? id;
  final DateTime dataInicio;
  final DateTime? dataFim;
  final String local;

  Trip({this.id, this.dataFim, required this.dataInicio, required this.local});

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'dataInicio': dataInicio.toIso8601String(),
      if (dataFim != null) 'dataFim': dataFim?.toIso8601String(),
      'local': local,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'],
      dataInicio: DateTime.parse(map['dataInicio']),
      dataFim: DateTime.tryParse(map['dataFim']) ?? DateTime(0000),
      local: map['local'],
    );
  }
}
