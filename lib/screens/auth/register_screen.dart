import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
const RegisterScreen({super.key});

@override
State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
final _nameController = TextEditingController();
final _birthController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

void _register() async {
final response = await ApiService.register(
name: _nameController.text,
birth: _birthController.text,
email: _emailController.text,
password: _passwordController.text,
);

if (response?['success'] == true) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cadastro realizado com sucesso')));
  Navigator.pushReplacementNamed(context, '/');
} else {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response?['error'] ?? 'Erro ao cadastrar')));
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Cadastro')),
body: Padding(
padding: const EdgeInsets.all(24),
child: ListView(
children: [
TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nome')),
const SizedBox(height: 12),
TextField(controller: _birthController, decoration: const InputDecoration(labelText: 'Data de nascimento')),
const SizedBox(height: 12),
TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
const SizedBox(height: 12),
TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Senha')),
const SizedBox(height: 24),
ElevatedButton(onPressed: _register, child: const Text('Cadastrar')),
],
),
),
);
}
}