import 'package:flutter/material.dart';

const String studentName = 'I Kadek Agus Dwi Adnyana';
const String studentId = '2415051076';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 1 - Non Responsive Layout',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tahap 1: Non-Responsive Layout'),
          backgroundColor: Colors.blueAccent,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 500,
                color: Colors.amber.shade200,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  '$studentId - $studentName (Hardcoded Width: 500)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    width: 500,
                    color: Colors.red.shade200,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Row Child (Width 500) -> Memicu Overflow di Mobile',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
