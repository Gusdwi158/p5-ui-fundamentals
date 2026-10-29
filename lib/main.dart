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
      title: 'Tahap 3 - LayoutBuilder Breakpoint',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ResponsiveBreakpointPage(),
    );
  }
}

class ResponsiveBreakpointPage extends StatelessWidget {
  const ResponsiveBreakpointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 3: LayoutBuilder & Breakpoint'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        // Menggunakan LayoutBuilder untuk membaca constraints parent
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return CompactLayout(maxWidth: constraints.maxWidth);
            } else if (constraints.maxWidth < 840) {
              return MediumLayout(maxWidth: constraints.maxWidth);
            } else {
              return ExpandedLayout(maxWidth: constraints.maxWidth);
            }
          },
        ),
      ),
    );
  }
}

// ==========================================
// 1. COMPACT LAYOUT (< 600 px) -> Phone
// Perbedaan visual: Kolom vertikal, aksen Merah/Oranye, ikon Smartphone
// ==========================================
class CompactLayout extends StatelessWidget {
  final double maxWidth;
  const CompactLayout({super.key, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade50,
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.smartphone, size: 64, color: Colors.redAccent),
          const SizedBox(height: 12),
          const Text(
            'Kategori: COMPACT LAYOUT (< 600 px)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          Text('Constraints Width: ${maxWidth.toStringAsFixed(1)} px'),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    studentName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'NIM: $studentId',
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. MEDIUM LAYOUT (600 - 839 px) -> Tablet Portrait
// Perbedaan visual: Panel oranye/kuning, ikon Tablet, kartu horizontal
// ==========================================
class MediumLayout extends StatelessWidget {
  final double maxWidth;
  const MediumLayout({super.key, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange.shade50,
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.tablet_android, size: 80, color: Colors.orange),
            const SizedBox(width: 24),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kategori: MEDIUM LAYOUT (600 - 839 px)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                Text('Constraints Width: ${maxWidth.toStringAsFixed(1)} px'),
                const SizedBox(height: 8),
                Text(
                  '$studentName ($studentId)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. EXPANDED LAYOUT (>= 840 px) -> Desktop / Large Tablet
// Perbedaan visual: Panel biru/hijau cerah, ikon Desktop/Laptop, banner dua kolom luas
// ==========================================
class ExpandedLayout extends StatelessWidget {
  final double maxWidth;
  const ExpandedLayout({super.key, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade50,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.desktop_windows,
                    size: 90,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Sidebar / Panel Kiri',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kategori: EXPANDED LAYOUT (>= 840 px)',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Constraints Max Width: ${maxWidth.toStringAsFixed(1)} px',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(height: 24),
                    Text(
                      'Praktikan : $studentName',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'NIM       : $studentId',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
