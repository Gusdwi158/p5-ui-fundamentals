import 'package:flutter/material.dart';

const String studentName = 'I Kadek Agus Dwi Adnyana';
const String studentId = '2415051076';

// Data list statis tanpa tanda kurung generic bersarang
const List courseList = [
  {
    'title': 'Git & GitHub',
    'code': 'MOB01',
    'credits': 2,
    'status': 'done',
    'lecturer': 'Dosen Pemrograman Mobile',
    'description': 'Mempelajari version control system, branching, merging, dan kolaborasi repositori proyek mobile.',
  },
  {
    'title': 'Dart Fundamentals',
    'code': 'MOB02',
    'credits': 2,
    'status': 'done',
    'lecturer': 'Dosen Pemrograman Mobile',
    'description': 'Dasar-dasar bahasa pemrograman Dart, tipe data, OOP, null safety, dan asynchronous programming.',
  },
  {
    'title': 'Flutter UI Fundamentals',
    'code': 'MOB03',
    'credits': 3,
    'status': 'active',
    'lecturer': 'Dosen Pemrograman Mobile',
    'description': 'Membangun hierarki antarmuka, widget dasar, layouting adaptif, dan responsivitas layar.',
  },
  {
    'title': 'Navigation & Routing',
    'code': 'MOB04',
    'credits': 2,
    'status': 'planned',
    'lecturer': 'Dosen Pemrograman Mobile',
    'description': 'Mekanisme perpindahan layar, navigation stack (push/pop), dan passing data antar route.',
  },
  {
    'title': 'State Management',
    'code': 'MOB05',
    'credits': 3,
    'status': 'planned',
    'lecturer': 'Dosen Pemrograman Mobile',
    'description': 'Pengelolaan state aplikasi berskala menengah hingga kompleks secara terstruktur.',
  },
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 8 - Passing Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CourseListPage(),
    );
  }
}

// ==========================================
// 1. LIST SCREEN (Pengirim Data)
// ==========================================
class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 8: Daftar Course'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Header Identitas Mahasiswa
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.blue, size: 36),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
            const SizedBox(height: 16),
            const Text(
              'Pilih Course untuk Melihat Detail:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Iterasi List Course
            ...courseList.map((item) {
              final course = item as Map;
              final String status = course['status'].toString();
              final bool isDone = status == 'done';
              final bool isActive = status == 'active';

              final Color statusColor = isDone
                  ? Colors.green
                  : (isActive ? Colors.blue : Colors.orange);

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: statusColor.withValues(alpha: 0.15),
                    child: Icon(
                      isDone
                          ? Icons.check
                          : (isActive ? Icons.play_arrow : Icons.schedule),
                      color: statusColor,
                    ),
                  ),
                  title: Text(
                    course['title'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${course['code']} • ${course['credits']} SKS',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  // Passing Data via Constructor
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseDetailPage(course: course),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. DETAIL SCREEN (Penerima Data)
// ==========================================
class CourseDetailPage extends StatelessWidget {
  final Map course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final String status = course['status'].toString();
    final bool isDone = status == 'done';
    final bool isActive = status == 'active';

    final Color statusColor = isDone
        ? Colors.green
        : (isActive ? Colors.blue : Colors.orange);
    final String statusText = isDone
        ? 'Selesai'
        : (isActive ? 'Sedang Berjalan' : 'Rencana');

    return Scaffold(
      appBar: AppBar(
        title: Text(course['title'].toString()),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              statusText,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Text(
                            course['code'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        course['title'].toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Beban Perkuliahan: ${course['credits']} SKS',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        'Dosen Pengampu: ${course['lecturer']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const Divider(height: 28),
                      const Text(
                        'Deskripsi Materi:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        course['description']?.toString() ??
                            'Tidak ada deskripsi tersedia.',
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                      const Divider(height: 28),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.school, color: Colors.blueAccent),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Praktikan: $studentName ($studentId)',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Daftar Course'),
                style: ElevatedButton.styleFrom(
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
