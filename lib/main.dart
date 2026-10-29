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
      title: 'Tahap 4 - Expanded, Flexible, Wrap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FlexWrapDemoPage(),
    );
  }
}

class FlexWrapDemoPage extends StatelessWidget {
  const FlexWrapDemoPage({super.key});

  final List<String> skills = const [
    'Flutter',
    'Dart',
    'UI Design',
    'Git & GitHub',
    'REST API',
    'State Management',
  ];

  Widget buildBox(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 4: Expanded, Flexible, Wrap'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Identitas Mahasiswa
              Text(
                '$studentId - $studentName',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const Divider(height: 24),

              // Bagian 1: Dua panel Expanded dengan flex 2:1
              const Text(
                '1. Dua Panel Row dengan Expanded (Flex 2 : 1)',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: buildBox(
                      'Panel A (Flex 2 - 66.7%)',
                      Colors.blue.shade100,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: buildBox(
                      'Panel B (Flex 1 - 33.3%)',
                      Colors.orange.shade100,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Bagian 2: Minimal 6 Chip Skill menggunakan Wrap
              const Text(
                '2. Daftar Skill Menggunakan Wrap (Multi-line adaptif)',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills
                    .map(
                      (e) => Chip(
                        avatar: const CircleAvatar(
                          child: Icon(Icons.check, size: 14),
                        ),
                        label: Text(e),
                        backgroundColor: Colors.green.shade50,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),

              // Bagian 3: Komparasi jika menggunakan Row biasa (Beresiko Overflow)
              const Text(
                '3. Perbandingan: Chip dalam SingleChildScrollView Row',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: skills
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(
                            label: Text(e),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
