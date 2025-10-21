import 'package:flutter/material.dart';
import 'home.dart';
import 'bukti_transfer.dart'; // import halaman bukti transfer

class TransferForm extends StatefulWidget {
  const TransferForm({super.key});

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final Color primaryColor = const Color(0xFF9C27B0);

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController pesanController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    nominalController.dispose();
    pesanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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
                        Navigator.pop(
                          context,
                        ); // cukup pop agar kembali ke HomePage
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "DECA",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Input nama/email
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  hintText: "Masukkan nama atau email",
                  hintStyle: TextStyle(color: Colors.blue),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sumber Dana
              const Text("Sumber Dana", style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cash",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rp ${HomePage.saldo.toStringAsFixed(0)}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Nominal Transfer
              TextField(
                controller: nominalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Nominal Transfer",
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Pesan Opsional
              TextField(
                controller: pesanController,
                decoration: const InputDecoration(
                  labelText: "Pesan (opsional)",
                  labelStyle: TextStyle(color: Colors.black54),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),

              const Spacer(),

              // Tombol Lanjutkan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    final nama = namaController.text.trim();
                    final nominalText = nominalController.text.trim();
                    final pesan = pesanController.text.trim();

                    if (nama.isEmpty || nominalText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Lengkapi data terlebih dahulu"),
                        ),
                      );
                      return;
                    }

                    final nominal = double.tryParse(nominalText) ?? 0;

                    if (nominal <= 0 || nominal > HomePage.saldo) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Nominal tidak valid atau saldo tidak cukup",
                          ),
                        ),
                      );
                      return;
                    }


                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => TransferSuccessPage(
                              namaPengirim: "User A",
                              jenisTransaksi: "Transfer",
                              namaPenerima: nama,
                              nominal: nominal,
                              tanggal: DateTime.now().toString().substring(
                                0,
                                19,
                              ),
                              keterangan: pesan,
                            ),
                      ),
                    );
                  },
                  child: const Text(
                    "LANJUTKAN",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
