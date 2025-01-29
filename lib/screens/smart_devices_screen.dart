import 'package:flutter/material.dart';
import '../services/esp32_service.dart';

class SmartDevicesScreen extends StatefulWidget {
  @override
  _SmartDevicesScreenState createState() => _SmartDevicesScreenState();
}

class _SmartDevicesScreenState extends State<SmartDevicesScreen> {
  final ESP32Service esp32Service = ESP32Service();
  bool isFanOn = false;
  double gasLevel = 0.0;
  bool gasLeakDetected = false;

  @override
  void initState() {
    super.initState();
    fetchDeviceData();
  }

  Future<void> fetchDeviceData() async {
    try {
      double newGasLevel = await esp32Service.getGasLevel();
      bool newGasLeakStatus = await esp32Service.getGasLeakStatus();

      setState(() {
        gasLevel = newGasLevel;
        gasLeakDetected = newGasLeakStatus;
      });

      if (gasLeakDetected) {
        esp32Service.toggleFan(true);  // Auto turn on fan if gas leak detected
        esp32Service.openWindows();    // Auto open windows
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void toggleFan() async {
    setState(() {
      isFanOn = !isFanOn;
    });
    await esp32Service.toggleFan(isFanOn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Devices")),
      body: Column(
        children: [
          ListTile(
            title: Text("Gas Level"),
            subtitle: Text("$gasLevel PPM"),
            trailing: gasLevel > 1000 ? Icon(Icons.warning, color: Colors.red) : Icon(Icons.check, color: Colors.green),
          ),
          ListTile(
            title: Text("Gas Leak Detected"),
            subtitle: Text(gasLeakDetected ? "Yes" : "No"),
            trailing: gasLeakDetected ? Icon(Icons.error, color: Colors.red) : Icon(Icons.check, color: Colors.green),
          ),
          SwitchListTile(
            title: Text("Smart Fan"),
            subtitle: Text(isFanOn ? "On" : "Off"),
            value: isFanOn,
            onChanged: (value) => toggleFan(),
          ),
          if (gasLeakDetected)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Gas Leak Detected! Fan & Windows Activated Automatically.",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: fetchDeviceData,
      ),
    );
  }
}
