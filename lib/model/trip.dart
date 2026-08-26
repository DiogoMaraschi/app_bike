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
      id: map['id'] as int?,
      dataInicio: DateTime.parse(map['dataInicio'] as String),
      dataFim: map['dataFim'] == null
          ? null
          : DateTime.parse(map['dataFim'] as String),
      local: map['local'] as String,
    );
  }
}
