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
      title: 'Tahap 11 - Adaptive Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AdaptiveShellPage(),
    );
  }
}

class AdaptiveShellPage extends StatefulWidget {
  const AdaptiveShellPage({super.key});

  @override
  State<AdaptiveShellPage> createState() => _AdaptiveShellPageState();
}

class _AdaptiveShellPageState extends State<AdaptiveShellPage> {
  // Poin 46: selectedIndex tetap terjaga saat resize layar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeTab(),
      const CoursesTab(),
      const ProfileTab(),
    ];

    // Poin 43: LayoutBuilder pada shell aplikasi
    return LayoutBuilder(
      builder: (context, constraints) {
        // Poin 44: Compact/Medium (< 840px) menggunakan NavigationBar
        if (constraints.maxWidth < 840) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Adaptive Nav: Compact/Medium (${constraints.maxWidth.toStringAsFixed(0)}px)',
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              centerTitle: true,
            ),
            body: SafeArea(child: pages[selectedIndex]),
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }

        // Poin 45: Expanded (>= 840px) menggunakan NavigationRail
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Adaptive Nav: Expanded Screen (${constraints.maxWidth.toStringAsFixed(0)}px)',
            ),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                leading: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Icon(Icons.devices, size: 32, color: Colors.blue),
                ),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.school_outlined),
                    selectedIcon: Icon(Icons.school),
                    label: Text('Courses'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: SafeArea(child: pages[selectedIndex])),
            ],
          ),
        );
      },
    );
  }
}

// ==========================================
// 1. HOME TAB (Identitas Mahasiswa)
// ==========================================
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.person_pin, size: 44, color: Colors.blue),
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
                      SizedBox(height: 4),
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
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                'Uji perubahan navigasi secara responsif dengan memperbesar atau memperkecil ukuran jendela browser/emulator melewati batas 840px.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. COURSES TAB
// ==========================================
class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List courses = const [
      {'title': 'Git & GitHub', 'code': 'MOB01', 'sks': 2},
      {'title': 'Dart Fundamentals', 'code': 'MOB02', 'sks': 2},
      {'title': 'Flutter UI Fundamentals', 'code': 'MOB03', 'sks': 3},
      {'title': 'Navigation & Routing', 'code': 'MOB04', 'sks': 2},
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daftar Mata Kuliah',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final c = courses[index] as Map;
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(c['title'].toString()),
                    subtitle: Text('${c['code']} • ${c['sks']} SKS'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. PROFILE TAB
// ==========================================
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 36,
                  child: Icon(Icons.account_circle, size: 48),
                ),
                SizedBox(height: 16),
                Text(
                  studentName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  'NIM: $studentId',
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                ),
                Text(
                  'Pendidikan Teknik Informatika - Undiksha',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
