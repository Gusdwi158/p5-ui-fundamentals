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
      title: 'Tahap 2 - MediaQuery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MediaQueryDemoPage(),
    );
  }
}

class MediaQueryDemoPage extends StatelessWidget {
  const MediaQueryDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Membaca karakteristik layar menggunakan MediaQuery
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final orientation = mediaQuery.orientation;

    // 2. Evaluasi kondisi breakpoint sederhana (< 600 px)
    final bool isCompact = size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 2: MediaQuery'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Identitas Praktikan Wajib
                    const Text(
                      'Identitas Praktikan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      studentName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'NIM: $studentId',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const Divider(height: 28),

                    // Output Karakteristik Layar
                    const Text(
                      'Karakteristik Layar:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Width: ${size.width.toStringAsFixed(0)} px',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Height: ${size.height.toStringAsFixed(0)} px',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Orientation: ${orientation.name.toUpperCase()}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 18),

                    // Status Layout Sesuai Kondisi
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: isCompact
                            ? Colors.orange.shade100
                            : Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isCompact ? Colors.orange : Colors.green,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        'Kategori Layout: ${isCompact ? "Compact" : "Wide"}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isCompact
                              ? Colors.orange.shade900
                              : Colors.green.shade900,
                        ),
                      ),
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
}
