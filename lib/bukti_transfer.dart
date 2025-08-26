import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TransferSuccessPage(),
    );
  }
}

class TransferSuccessPage extends StatelessWidget {
  const TransferSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
              ),
              const Text(
                "-Tanggal Transaksi-",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),

              const Text(
                "~Nominal~",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 30),

              // Detail informasi (kiri label, kanan isi)
              RowInfo("Nama Pengirim", "Nama Pengirim"),
              RowInfo("Jenis Transaksi", "Jenis Transaksi"),
              RowInfo("Nama Penerima", "Nama Penerima"),
              RowInfo("Nominal Transfer", "Nominal Transfer"),
              RowInfo("Tanggal Transfer", "Tanggal Transfer"),
              RowInfo("Keterangan", "Keterangan"),

              const Spacer(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  // aksi tombol
                  Navigator.pop(context);
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
          Text(label,
              style: const TextStyle(color: Colors.black87, fontSize: 14)),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 14)),
        ],
      ),
    );
  }
}