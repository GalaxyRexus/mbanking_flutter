import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50, // biar agak mirip bg soft
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "DECApay",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 16),

            // Kartu Saldo
// Kartu Saldo + menu atas di dalam card
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.purple,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Della Sabrina - 0022345789",
          style: TextStyle(color: Colors.white)),
      const SizedBox(height: 8),
      const Text("Total Saldo", style: TextStyle(color: Colors.white70)),
      const Text("Rp 1.000.000.000",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),

      // Menu atas dipindah ke dalam card
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          MenuAtas(icon: Icons.add_circle_outline, label: "Top Up",),
          MenuAtas(icon: Icons.send, label: "Transfer"),
          MenuAtas(icon: Icons.money_off, label: "Tarik Tunai"),
          MenuAtas(icon: Icons.receipt, label: "Riwayat"),
        ],
      ),
    ],
  ),
),

            const SizedBox(height: 12),

            // Menu atas (icon + text)
            

            const SizedBox(height: 24),
            const Text("Menu Lain"),

            const SizedBox(height: 16),

            // Menu lain (ikon lebih berwarna)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                MenuLain(icon: Icons.phone, label: "Pulsa", color: Colors.blue),
                MenuLain(icon: Icons.flash_on, label: "PLN", color: Colors.orange),
                MenuLain(icon: Icons.opacity, label: "PDAM", color: Colors.lightBlue),
                MenuLain(icon: Icons.signal_cellular_alt, label: "Paket Data", color: Colors.teal),
              ],
            ),

            const SizedBox(height: 24),
            Row(
              children: const [
                Icon(Icons.settings, size: 40, color: Colors.grey),
                SizedBox(width: 8),
                Text("Pengaturan"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Widget untuk menu atas
class MenuAtas extends StatelessWidget {
  final IconData icon;
  final String label;
  const MenuAtas({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.white70),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// Widget untuk menu lain
class MenuLain extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const MenuLain(
      {super.key, required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 28,
          child: Icon(icon, size: 28, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}