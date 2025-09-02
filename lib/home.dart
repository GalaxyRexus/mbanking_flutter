import 'package:flutter/material.dart';
import 'form_transfer.dart';
import 'pengaturan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DECApay",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Color primaryColor = const Color(0xFF9C27B0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "DECApay",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 12),

              // Card Saldo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Delia Sabrina - 0022345789",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Total Saldo",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const Text(
                      "Rp 1.000.000.000",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _MenuIcon(
                          icon: Icons.add_circle,
                          label: "Top Up",
                          onTap: () => _goToPage(context, "Top Up"),
                        ),
                        _MenuIcon(
                          icon: Icons.send,
                          label: "Transfer",
                          onTap: () => _goToPage(context, "Transfer"),
                        ),
                        _MenuIcon(
                          icon: Icons.money_off,
                          label: "Tarik Tunai",
                          onTap: () => _goToPage(context, "Tarik Tunai"),
                        ),
                        _MenuIcon(
                          icon: Icons.history,
                          label: "Riwayat",
                          onTap: () => _goToPage(context, "Riwayat"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Menu Lain",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // Grid Menu
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _MenuGrid(
                      icon: Icons.phone,
                      label: "Pulsa",
                      color: Colors.blue,
                      onTap: () => _goToPage(context, "Pulsa"),
                    ),
                    _MenuGrid(
                      icon: Icons.flash_on,
                      label: "PLN",
                      color: Colors.orange,
                      onTap: () => _goToPage(context, "PLN"),
                    ),
                    _MenuGrid(
                      icon: Icons.water_drop,
                      label: "PDAM",
                      color: Colors.lightBlue,
                      onTap: () => _goToPage(context, "PDAM"),
                    ),
                    _MenuGrid(
                      icon: Icons.signal_cellular_alt,
                      label: "Paket Data",
                      color: Colors.green,
                      onTap: () => _goToPage(context, "Paket Data"),
                    ),
                    _MenuGrid(
                      icon: Icons.settings,
                      label: "Pengaturan",
                      color: Colors.grey,
                      onTap: () => _goToPage(context, "Pengaturan"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi Navigasi ke halaman baru
}
// Di dalam class HomePage
void _goToPage(BuildContext context, String page) {
  if (page == "Transfer") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TransferForm()),
    );
  } else if (page == "Top Up") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DummyPage(title: "Top Up")),
    );
  } else if (page == "Tarik Tunai") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DummyPage(title: "Tarik Tunai")),
    );
  } else if (page == "Riwayat") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DummyPage(title: "Riwayat")),
    );
  }
   else if (page == "Pengaturan"){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PengaturanPage()),
    );
   }
}
// Widget untuk ikon di dalam Card Saldo 
class _MenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _MenuIcon({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0), // area klik lebih nyaman
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}


// Widget untuk Grid Menu
class _MenuGrid extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _MenuGrid({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: color.withOpacity(0.2), 
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(), // ripple bulat
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(icon, color: color, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// Halaman Dummy untuk contoh navigasi
class DummyPage extends StatelessWidget {
  final String title;

  const DummyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text("Halaman $title", style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
