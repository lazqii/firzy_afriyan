import 'package:flutter/material.dart';

void main() {
  runApp(IPKCalculatorApp());
}

class IPKCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPK Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IPKCalculatorHomePage(),
    );
  }
}

class IPKCalculatorHomePage extends StatefulWidget {
  @override
  _IPKCalculatorHomePageState createState() => _IPKCalculatorHomePageState();
}

class _IPKCalculatorHomePageState extends State<IPKCalculatorHomePage> {
  List<double> nilai = [0, 0, 0]; // Array untuk menyimpan nilai mata kuliah
  List<double> bobot = [0, 0, 0]; // Array untuk menyimpan bobot mata kuliah
  double? _ipkResult;

  void _calculateIPK() {
    double totalGrade = 0.0;
    double totalCredits = 0.0;

    // Hitung total nilai (nilai x bobot) dari setiap mata kuliah
    for (int i = 0; i < nilai.length; i++) {
      totalGrade += nilai[i] * bobot[i];
      totalCredits += bobot[i];
    }

    // Hitung IPK dengan membagi total nilai dengan total bobot
    double ipk = totalGrade / totalCredits;

    setState(() {
      _ipkResult = ipk;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IPK Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < 3; i++) ...[
              TextField(
                onChanged: (value) {
                  nilai[i] = double.tryParse(value) ?? 0.0;
                },
                decoration:
                    InputDecoration(labelText: 'Nilai Mata Kuliah ${i + 1}'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 12.0),
              TextField(
                onChanged: (value) {
                  bobot[i] = double.tryParse(value) ?? 0.0;
                },
                decoration:
                    InputDecoration(labelText: 'Bobot Mata Kuliah ${i + 1}'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 12.0),
            ],
            ElevatedButton(
              onPressed: _calculateIPK,
              child: Text('Hitung IPK'),
            ),
            SizedBox(height: 12.0),
            _ipkResult != null
                ? Text('IPK Anda: ${_ipkResult!.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                : Container(),
          ],
        ),
      ),
    );
  }
}
