import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class RecordsScreen extends StatelessWidget {
  final int userId;

  const RecordsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Temperaturas')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ApiService.getTemperaturas(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os dados.'));
          }

          final registros = snapshot.data ?? [];

          if (registros.isEmpty) {
            return const Center(child: Text('Nenhum registro encontrado.'));
          }

          return ListView.builder(
            itemCount: registros.length,
            itemBuilder: (context, index) {
              final item = registros[index];
              final double temp = item['temperatura'];
              final bool quente = temp >= 30;
              return ListTile(
                leading: Icon(Icons.thermostat, color: quente ? Colors.red : Colors.blue),
                title: Text('${temp.toStringAsFixed(1)} °C'),
                subtitle: Text('Data: ${item['data']}'),
                trailing: Text(quente ? 'Quente' : 'Frio'),
              );
            },
          );
        },
      ),
    );
  }
}
