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
      title: 'Tahap 6 - Scrollable Content',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProfileFormPage(),
    );
  }
}

class ProfileFormPage extends StatelessWidget {
  const ProfileFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 6: Scrollable & Keyboard'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        // SingleChildScrollView mencegah RenderFlex overflow saat keyboard muncul
        child: SingleChildScrollView(
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
                      CircleAvatar(
                        radius: 26,
                        child: Icon(Icons.person, size: 28),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
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
                              'NIM: $studentId',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Formulir Profil Mahasiswa
              const Text(
                'Formulir Pembaruan Profil',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  hintText: studentName,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.badge),
                ),
              ),
              const SizedBox(height: 14),

              TextField(
                decoration: InputDecoration(
                  labelText: 'NIM',
                  hintText: studentId,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.numbers),
                ),
              ),
              const SizedBox(height: 14),

              const TextField(
                decoration: InputDecoration(
                  labelText: 'Program Studi',
                  hintText: 'Pendidikan Teknik Informatika',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.school),
                ),
              ),
              const SizedBox(height: 14),

              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon / WhatsApp',
                  hintText: '08xxxxxxxxxx',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 14),

              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Alamat Domisili',
                  hintText: 'Singaraja, Buleleng, Bali',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.home),
                ),
              ),
              const SizedBox(height: 14),

              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Bio / Catatan Praktikum',
                  hintText: 'Eksplorasi responsivitas antarmuka dan penanganan input keyboard...',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.edit_note),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save),
                label: const Text('Simpan Perubahan'),
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
