// widgets/temperatura_card.dart
import 'package:flutter/material.dart';

class TemperatureCard extends StatelessWidget {
  final double temperatureValue;

  const TemperatureCard({super.key, required this.temperatureValue});

  @override
  Widget build(BuildContext context) {
    final bool isHot = temperatureValue > 27;

    return Card(
      color: isHot ? Colors.orange : Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Icon(
              isHot ? Icons.thermostat : Icons.ac_unit,
              color: Colors.white,
              size: 80,
            ),
            const SizedBox(height: 10),
            Text(
              isHot ? 'Quente' : 'Frio',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
