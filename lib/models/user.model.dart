class User {
  final String name;
  final DateTime birth;
  final String email;
  // Não armazenar senha aqui. Se quiser, pode ter um campo para hash, mas não recomendo.
  final String? phone;

  User({
    required this.name,
    required this.birth,
    required this.email,
    this.phone,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'birth': birth.toIso8601String(),
    'email': email,
    'phone': phone,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    name: map['name'],
    birth: DateTime.parse(map['birth']),
    email: map['email'],
    phone: map['phone'],
  );
}