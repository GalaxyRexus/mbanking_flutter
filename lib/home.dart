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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "DECAPay",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Kartu Saldo
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.purple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Della Sabrina - 0022345789",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Text("Total Saldo", style: TextStyle(color: Colors.white)),
                  Text("Rp 1.000.000.000",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Menu atas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("Top Up"),
                Text("Transfer"),
                Text("Tarik Tunai"),
                Text("Riwayat"),
              ],
            ),

            const SizedBox(height: 24),
            const Text("Menu Lain"),

            const SizedBox(height: 16),

            // Menu lain
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.phone, size: 40),
                Icon(Icons.flash_on, size: 40),
                Icon(Icons.opacity, size: 40),
                Icon(Icons.signal_cellular_alt, size: 40),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("Pulsa"),
                Text("PLN"),
                Text("PDAM"),
                Text("Paket Data"),
              ],
            ),

            const SizedBox(height: 24),
            Row(
              children: const [
                Icon(Icons.settings, size: 40),
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