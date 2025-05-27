import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ResetPasswordScreen extends StatefulWidget {
const ResetPasswordScreen({super.key});

@override
State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
final _emailController = TextEditingController();
final _newPasswordController = TextEditingController();
final _confirmController = TextEditingController();
bool enviado = false;

void _enviar() {
if (_emailController.text.isNotEmpty) {
setState(() => enviado = true);
}
}

void _redefinir() async {
if (_newPasswordController.text != _confirmController.text) {
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Senhas não coincidem')));
return;
}

final res = await ApiService.resetPassword(
  email: _emailController.text,
  newPassword: _newPasswordController.text,
);

if (res?['success'] == true) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Sucesso'),
      content: const Text('Senha redefinida.'),
      actions: [TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/'), child: const Text('OK'))],
    ),
  );
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Redefinir senha')),
body: Padding(
padding: const EdgeInsets.all(24),
child: ListView(
children: [
if (!enviado) ...[
TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
const SizedBox(height: 16),
ElevatedButton(onPressed: _enviar, child: const Text('Enviar link')),
] else ...[
TextField(controller: _newPasswordController, decoration: const InputDecoration(labelText: 'Nova senha'), obscureText: true),
const SizedBox(height: 12),
TextField(controller: _confirmController, decoration: const InputDecoration(labelText: 'Confirmar senha'), obscureText: true),
const SizedBox(height: 16),
ElevatedButton(onPressed: _redefinir, child: const Text('Redefinir')),
],
],
),
),
);
}
}