import 'package:flutter/material.dart';
import 'home.dart'; // untuk ambil saldo global

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // ✅ jalan
    );
  }
}

class TransferSuccessPage extends StatelessWidget {
  final String namaPengirim;
  final String jenisTransaksi;
  final String namaPenerima;
  final double nominal;
  final String tanggal;
  final String keterangan;

  const TransferSuccessPage({
    super.key,
    required this.namaPengirim,
    required this.jenisTransaksi,
    required this.namaPenerima,
    required this.nominal,
    required this.tanggal,
    required this.keterangan,
  });

  @override
  Widget build(BuildContext context) {
    // kurangi saldo global saat halaman ini dipanggil
    if (HomePage.saldo >= nominal) {
      HomePage.saldo -= nominal;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // Icon lingkaran gradient
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent.shade100,
                child: const Icon(Icons.check, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 20),

              const Text(
                "Transfer Berhasil",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                "Rp ${nominal.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),

              // Detail informasi
              RowInfo("Nama Pengirim", namaPengirim),
              RowInfo("Jenis Transaksi", jenisTransaksi),
              RowInfo("Nama Penerima", namaPenerima),
              RowInfo("Nominal Transfer", "Rp ${nominal.toStringAsFixed(0)}"),
              RowInfo("Tanggal Transfer", tanggal),
              RowInfo("Keterangan", keterangan.isEmpty ? "-" : keterangan),
              RowInfo("Sisa Saldo", "Rp ${HomePage.saldo.toStringAsFixed(0)}"),

              const Spacer(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  // kembali ke home sambil reset navigation stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
                  );
                },
                child: const Text("Cetak & Kembali"),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class RowInfo extends StatelessWidget {
  final String label;
  final String value;
  const RowInfo(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
