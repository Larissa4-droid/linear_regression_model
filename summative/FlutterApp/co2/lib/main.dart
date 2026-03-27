import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore_for_file: library_private_types_in_public_api
void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CO2Predictor(),
    ));

class CO2Predictor extends StatefulWidget {
  const CO2Predictor({super.key});

  @override
  _CO2PredictorState createState() => _CO2PredictorState();
}

class _CO2PredictorState extends State<CO2Predictor> {
  final TextEditingController _engineSize = TextEditingController();
  final TextEditingController _cylinders = TextEditingController();
  final TextEditingController _fuel = TextEditingController();
  String _result = "Result will appear here";
  bool _isLoading = false;

  Future<void> getPrediction() async {
    const String url = "https://linearregressionmodel-production.up.railway.app/predict";
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "engine_size": double.parse(_engineSize.text),
          "cylinders": int.parse(_cylinders.text),
          "fuel_consumption": double.parse(_fuel.text),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _result = "${data['predicted_co2_emissions']} g/km";
        });
      } else {
        setState(() => _result = "Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _result = "Check Connection");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade900, Colors.green.shade500],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.eco, size: 60, color: Colors.green.shade700),
                    const SizedBox(height: 10),
                    const Text(
                      "CO2 Predictor",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text("Enter vehicle specs below", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 30),
                    _buildInput(_engineSize, "Engine Size (L)", Icons.settings_input_component),
                    const SizedBox(height: 15),
                    _buildInput(_cylinders, "Cylinders", Icons.reorder),
                    const SizedBox(height: 15),
                    _buildInput(_fuel, "Fuel Consumption", Icons.local_gas_station),
                    const SizedBox(height: 30),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: getPrediction,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade700,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            ),
                            child: const Text("PREDICT NOW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const Text("Predicted Emission", style: TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 5),
                    Text(
                      _result,
                      style: TextStyle(fontSize: 28, color: Colors.green.shade900, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}