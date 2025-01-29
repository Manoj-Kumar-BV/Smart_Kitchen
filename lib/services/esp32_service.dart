import 'dart:convert';
import 'package:http/http.dart' as http;

class ESP32Service {
  static const String baseUrl = "http://your-esp32-ip";  // Change this to your ESP32's IP

  Future<double> getGasLevel() async {
    final response = await http.get(Uri.parse("$baseUrl/gas_level"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['gas_level'];  // Assuming ESP32 returns {'gas_level': value}
    } else {
      throw Exception("Failed to fetch gas level");
    }
  }

  Future<bool> getGasLeakStatus() async {
    final response = await http.get(Uri.parse("$baseUrl/gas_leak"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['leak_detected'];  // Assuming {'leak_detected': true/false}
    } else {
      throw Exception("Failed to fetch gas leak status");
    }
  }

  Future<void> toggleFan(bool isOn) async {
    await http.post(Uri.parse("$baseUrl/fan"), body: jsonEncode({'state': isOn}));
  }

  Future<void> openWindows() async {
    await http.post(Uri.parse("$baseUrl/windows"), body: jsonEncode({'state': true}));
  }
}
