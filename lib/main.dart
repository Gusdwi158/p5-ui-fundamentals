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
      title: 'Tahap 9 - Returning Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CourseSelectionPage(),
    );
  }
}

// ==========================================
// 1. HALAMAN AWAL (Menunggu & Menerima Nilai Balikan)
// ==========================================
class CourseSelectionPage extends StatefulWidget {
  const CourseSelectionPage({super.key});

  @override
  State<CourseSelectionPage> createState() => _CourseSelectionPageState();
}

class _CourseSelectionPageState extends State<CourseSelectionPage> {
  String selectedCourseTitle = 'Belum ada course yang dipilih';

  // Fungsi navigasi yang meng-await kembalian nilai dari DetailPage
  Future openDetailAndSelect(BuildContext context, String title) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CourseDetailPage(courseTitle: title)),
    );

    // Poin 37: Tampilkan SnackBar jika result == true
    if (result == true && mounted) {
      setState(() {
        selectedCourseTitle = title;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course "$title" berhasil ditambahkan ke Favorite!'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 9: Returning Data'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Identitas Mahasiswa Praktikan
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue, size: 36),
                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'NIM: $studentId | PTI 5 A',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Status Pilihan Terkini
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Course Favorit Terpilih:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      selectedCourseTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Pilih salah satu course:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 8),

              // Daftar Item yang dapat dibuka
              Card(
                elevation: 1,
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.code)),
                  title: const Text('Flutter UI Fundamentals'),
                  subtitle: const Text('MOB03 • 3 SKS'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      openDetailAndSelect(context, 'Flutter UI Fundamentals'),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 1,
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.navigation)),
                  title: const Text('Navigation & Routing'),
                  subtitle: const Text('MOB04 • 2 SKS'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      openDetailAndSelect(context, 'Navigation & Routing'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. HALAMAN DETAIL (Mengirim Data Balikan true)
// ==========================================
class CourseDetailPage extends StatelessWidget {
  final String courseTitle;

  const CourseDetailPage({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Course'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.bookmark_border,
                size: 72,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 16),
              Text(
                courseTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Praktikan: $studentName ($studentId)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 32),

              // Poin 35 & 36: Tombol Pilih/Favorite mengembalikan nilai true
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.favorite),
                label: const Text('Pilih / Favorite (Kirim true)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 12),

              // Tombol Batal mengembalikan nilai false / null
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                icon: const Icon(Icons.close),
                label: const Text('Batal / Kembali'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
