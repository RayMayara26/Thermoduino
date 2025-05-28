class Temperature {
  final int? id;
  final DateTime dateTime;
  final double value;

  Temperature({this.id, required this.dateTime, required this.value});

  Map<String, dynamic> toMap() => {
    'id': id,
    'dateTime': dateTime.toIso8601String(),
    'value': value,
  };

  factory Temperature.fromMap(Map<String, dynamic> map) => Temperature(
    id: map['id'],
    dateTime: DateTime.parse(map['dateTime']),
    value: map['value'].toDouble(),
  );
}