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
      title: 'Tahap 13 - Form & Validasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FeedbackFormPage(),
    );
  }
}

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  // GlobalKey untuk mengontrol status validasi Form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controller dengan nilai default dari konstanta identitas (Poin 51 & 52)
  late final TextEditingController nameController;
  late final TextEditingController idController;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: studentName);
    idController = TextEditingController(text: studentId);
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    commentController.dispose();
    super.dispose();
  }

  // Poin 54: Validasi form sebelum menampilkan hasil
  void submitForm() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
          title: const Text('Validasi Berhasil!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${nameController.text}'),
              const SizedBox(height: 4),
              Text('NIM: ${idController.text}'),
              const SizedBox(height: 8),
              const Text(
                'Komentar / Feedback:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(commentController.text),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                commentController.clear();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 13: Form Input & Validasi'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
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
                      Icon(
                        Icons.assignment_turned_in,
                        color: Colors.blue,
                        size: 36,
                      ),
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

              // Formulir Feedback
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Form Feedback Mahasiswa',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Field 1: Nama Mahasiswa
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Mahasiswa',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nama wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // Field 2: NIM Mahasiswa
                        TextFormField(
                          controller: idController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'NIM Mahasiswa',
                            prefixIcon: Icon(Icons.badge),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'NIM wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // Field 3: Komentar (Poin 53: Minimal 5 karakter)
                        TextFormField(
                          controller: commentController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Komentar / Feedback',
                            hintText: 'Tuliskan masukan minimal 5 karakter...',
                            prefixIcon: Icon(Icons.comment),
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Komentar wajib diisi';
                            }
                            if (value.trim().length < 5) {
                              return 'Komentar wajib minimal 5 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Tombol Submit
                        ElevatedButton.icon(
                          onPressed: submitForm,
                          icon: const Icon(Icons.send),
                          label: const Text('Kirim Feedback'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
