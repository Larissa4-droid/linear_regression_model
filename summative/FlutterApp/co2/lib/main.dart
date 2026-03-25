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
  String _result = "Enter vehicle data to predict CO2";
  bool _isLoading = false;

  Future<void> getPrediction() async {
    // Your Live Railway API URL
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
          _result = "Predicted CO2: ${data['predicted_co2_emissions']} g/km";
        });
      } else {
        setState(() => _result = "API Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _result = "Check internet connection.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CO2 Emission Predictor"),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(Icons.directions_car, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              TextField(
                  controller: _engineSize,
                  decoration: const InputDecoration(
                    labelText: "Engine Size (Liters)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 15),
              TextField(
                  controller: _cylinders,
                  decoration: const InputDecoration(
                    labelText: "Number of Cylinders",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 15),
              TextField(
                  controller: _fuel,
                  decoration: const InputDecoration(
                    labelText: "Fuel Consumption (L/100km)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: getPrediction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Predict Now", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
