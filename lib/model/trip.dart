class Trip {
  final int? id;
  final DateTime dataInicio;
  final DateTime dataFim;

  Trip({this.id, required this.dataInicio, required this.dataFim});


  Map<String,dynamic> toMap() {
    return { if(id != null) 'id': id,
      'dataInicio': dataInicio,
      'dataFim': dataFim
    };
  }

  factory Trip.fromMap(Map<String,dynamic> map){
    return Trip( id: map['id'],dataInicio: map['dataInicio'], dataFim: map['dataFim']);
  }
}