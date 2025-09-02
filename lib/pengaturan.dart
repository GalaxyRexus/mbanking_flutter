import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const PengaturanPage());
}

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PrinterForm(),
    );
  }
}

class PrinterForm extends StatefulWidget {
  const PrinterForm({super.key});

  @override
  State<PrinterForm> createState() => _PrinterFormState();
}

class _PrinterFormState extends State<PrinterForm> {
  final Color primaryColor = const Color(0xFF9C27B0); // Ungu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan tombol kembali ke HomePage
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()),
                      );
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "PENGATURAN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // supaya teks tetap di tengah
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Daftar Printer
            Expanded(
              child: ListView(
                children: const [
                  PrinterTile(
                    name: "Nama Printer",
                    spec: "Spesifikasi",
                    date: "17 Agustus 1945",
                  ),
                  PrinterTile(
                    name: "Nama Printer",
                    spec: "Spesifikasi",
                    date: "17 Agustus 1945",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrinterTile extends StatelessWidget {
  final String name;
  final String spec;
  final String date;

  const PrinterTile({
    super.key,
    required this.name,
    required this.spec,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // kiri (nama + spesifikasi)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                spec,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
          // kanan (tanggal)
          Text(
            date,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
