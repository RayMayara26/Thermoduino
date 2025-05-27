import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class AccountScreen extends StatefulWidget {
  final int userId;

  const AccountScreen({super.key, required this.userId});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _name = TextEditingController();
  final _birth = TextEditingController();
  final _email = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  void carregar() async {
    final dados = await ApiService.getUser(widget.userId);
    if (dados != null) {
      _name.text = dados['name'];
      _birth.text = dados['birth'];
      _email.text = dados['email'];
    }
    setState(() => loading = false);
  }

  void atualizar() async {
    final ok = await ApiService.updateUser(
      id: widget.userId,
      name: _name.text,
      birth: _birth.text,
      email: _email.text,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? 'Atualizado' : 'Erro')),
    );
  }

  void deletar() async {
    final ok = await ApiService.deleteUser(widget.userId);
    if (ok && mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Conta')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  TextField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  TextField(
                    controller: _birth,
                    decoration: const InputDecoration(labelText: 'Nascimento'),
                  ),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: atualizar,
                    child: const Text('Alterar'),
                  ),
                  TextButton(
                    onPressed: deletar,
                    child: const Text('Deletar Conta'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (_) => false,
                    ),
                    child: const Text('Sair'),
                  ),
                ],
              ),
            ),
    );
  }
}
