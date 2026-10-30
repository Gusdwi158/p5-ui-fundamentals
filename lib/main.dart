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
      title: 'Tahap 14 - Feedback UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FeedbackDialogPage(),
    );
  }
}

class FeedbackDialogPage extends StatefulWidget {
  const FeedbackDialogPage({super.key});

  @override
  State<FeedbackDialogPage> createState() => _FeedbackDialogPageState();
}

class _FeedbackDialogPageState extends State<FeedbackDialogPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  // Poin 57: State untuk simulasi loading singkat
  bool isLoading = false;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  // Fungsi simulasi proses pengiriman data dengan delay
  Future processSubmission() async {
    setState(() {
      isLoading = true;
    });

    // Simulasi jaringan/proses selama 2 detik
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      isLoading = false;
      commentController.clear();
    });

    // Poin 55: Tampilkan SnackBar setelah form valid & proses selesai
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text('Feedback berhasil disimpan ke server!'),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Poin 56: AlertDialog sebelum aksi penting (submit data)
  void confirmSubmission() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Konfirmasi Pengiriman'),
          content: Text(
            'Apakah Anda yakin ingin mengirim komentar:\n"${commentController.text}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx); // Tutup dialog
                processSubmission(); // Jalankan simulasi loading
              },
              child: const Text('Ya, Kirim'),
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
        title: const Text('Tahap 14: SnackBar & Dialog'),
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
                        Icons.feedback_outlined,
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

              // Formulir Input
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
                          'Kirim Umpan Balik',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),

                        TextFormField(
                          controller: commentController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Isi Feedback',
                            hintText: 'Tuliskan masukan minimal 5 karakter...',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.edit_note),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Feedback tidak boleh kosong';
                            }
                            if (value.trim().length < 5) {
                              return 'Minimal 5 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Tombol dengan Indikator Loading
                        ElevatedButton(
                          onPressed: isLoading ? null : confirmSubmission,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.send),
                                    SizedBox(width: 8),
                                    Text('Kirim dengan Konfirmasi'),
                                  ],
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
