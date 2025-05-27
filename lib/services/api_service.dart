import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://SEU_IP:PORTA'; // Ex: http://192.168.0.100:3000

  // LOGIN
  static Future<int?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['userId'];
    } else {
      return null;
    }
  }
  // CADASTRO DE USUÁRIO
static Future<Map<String, dynamic>?> register({
  required String name,
  required String birth,
  required String email,
  required String password,
}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/register'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'birth': birth,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return {
      'success': false,
      'error': 'Erro ao cadastrar usuário: ${response.statusCode}'
    };
  }
}
  // ENVIO DE TEMPERATURA
  static Future<void> sendTemperature(double temperature, int userId) async {
    await http.post(
      Uri.parse('$baseUrl/temperature'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'temperature': temperature}),
    );
  }

  // GET USER BY ID
  static Future<Map<String, dynamic>?> getUser(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  // UPDATE USER
  static Future<bool> updateUser({
    required int id,
    required String name,
    required String birth,
    required String email,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'birth': birth,
        'email': email,
      }),
    );

    return response.statusCode == 200;
  }

  // DELETE USER
  static Future<bool> deleteUser(int userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200;
  }

  // ✅ AGORA DENTRO DA CLASSE
  static Future<List<Map<String, dynamic>>> getTemperaturas(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/temperature/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception('Erro ao carregar histórico de temperaturas');
    }
  }
}
