import 'package:flutter/material.dart';
import 'form_transfer.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/form_transfer': (context) => FormTransferPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Color primaryColor = const Color(0xFF9C27B0); // Ungu seperti di gambar

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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Total Saldo",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
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
                        const _MenuIcon(icon: Icons.add_circle, label: "Top Up"),
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            Navigator.pushNamed(context, '/form_transfer');
                          },
                          child: const _MenuIcon(icon: Icons.send, label: "Transfer"),
                        ),
                        const _MenuIcon(icon: Icons.money_off, label: "Tarik Tunai"),
                        const _MenuIcon(icon: Icons.history, label: "Riwayat"),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Menu Lain",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Grid Menu
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: const [
                    _MenuGrid(
                      icon: Icons.phone,
                      label: "Pulsa",
                      color: Colors.blue,
                    ),
                    _MenuGrid(
                      icon: Icons.flash_on,
                      label: "PLN",
                      color: Colors.orange,
                    ),
                    _MenuGrid(
                      icon: Icons.water_drop,
                      label: "PDAM",
                      color: Colors.lightBlue,
                    ),
                    _MenuGrid(
                      icon: Icons.signal_cellular_alt,
                      label: "Paket Data",
                      color: Colors.green,
                    ),
                    _MenuGrid(
                      icon: Icons.settings,
                      label: "Pengaturan",
                      color: Colors.grey,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk ikon di dalam Card Saldo
class _MenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MenuIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        )
      ],
    );
  }
}

// Widget untuk Grid Menu
class _MenuGrid extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MenuGrid(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
