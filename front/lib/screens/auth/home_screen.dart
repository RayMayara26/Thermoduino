  import 'package:flutter/material.dart';
  import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
  import '../../models/temperature_record.dart';
  import '../../services/api_service.dart';
  import '../../widgets/temperature_card.dart';

  class HomeScreen extends StatefulWidget {
    final int userId;
    const HomeScreen({super.key, required this.userId});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    BluetoothConnection? connection;
    bool isConnecting = true;
    bool get isConnected => connection != null && connection!.isConnected;

    double temperatureValue = 0.0;

    @override
    void initState() {
      super.initState();
      _connectBluetooth();
    }

    Future<void> _connectBluetooth() async {
      try {
        // Substitua pelo MAC real do seu HC-05
        String address = 'XX:XX:XX:XX:XX:XX';
        BluetoothConnection connectionLocal = await BluetoothConnection.toAddress(address);
        if (!mounted) return;
        setState(() {
          connection = connectionLocal;
          isConnecting = false;
        });
        connectionLocal.input?.listen(_onDataReceived).onDone(() {
          if (mounted) {
            setState(() {
              connection = null;
            });
          }
        });
      } catch (e) {
        if (mounted) {
          setState(() => isConnecting = false);
        }
        debugPrint('Erro conexão Bluetooth: $e');
      }
    }

    void _onDataReceived(Uint8List data) {
      String dataString = String.fromCharCodes(data).trim();
      double? temp = double.tryParse(dataString);
      if (temp != null && mounted) {
        setState(() {
          temperatureValue = temp;
        });
        ApiService.sendTemperature(temp, widget.userId);
      }
    }

    @override
    void dispose() {
      connection?.dispose();
      connection = null;
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      Color bgColor = temperatureValue > 27 ? Colors.orange : Colors.blue;

      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text('Thermoduino - Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
          ],
        ),
        body: Center(
          child: isConnecting
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${temperatureValue.toStringAsFixed(1)} °C',
                      style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    TemperatureCard(temperatureValue: temperatureValue),
                  ],
                ),
        ),
      );
    }
  }