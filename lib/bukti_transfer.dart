import 'package:flutter/material.dart';
import 'home.dart'; // untuk ambil saldo global
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

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

class BuktiTfPage extends StatefulWidget {
  final String namaPengirim;
  final String jenisTransaksi;
  final String namaPenerima;
  final double nominal;
  final String tanggal;
  final String keterangan;
  const BuktiTfPage({super.key, required this.namaPengirim, required this.jenisTransaksi, required this.namaPenerima, required this.nominal, required this.tanggal, required this.keterangan});

  @override
  State<BuktiTfPage> createState() => _BuktiTfPageState();
}

class _BuktiTfPageState extends State<BuktiTfPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  String formatRupiah(double amount) {
    final NumberFormat formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  void initState() {
    super.initState();
    initBluetooth();
  }

  Future<void> initBluetooth() async {
    // Meminta izin untuk akses Bluetooth
    var bluetoothStatus = await Permission.bluetooth.request();

    if (bluetoothStatus.isGranted) {
      // Periksa status Bluetooth
      bool? isConnected = await bluetooth.isConnected;
      bool? isOn = await bluetooth.isOn;

      if (isOn != null && !isOn) {
        // Tampilkan pesan untuk mengaktifkan Bluetooth
        print("Bluetooth tidak aktif, mohon aktifkan Bluetooth.");
      } else if (isConnected == null || !isConnected) {
        // Dapatkan daftar perangkat yang sudah terpasang
        List<BluetoothDevice> devices = await bluetooth.getBondedDevices();

        if (devices.isNotEmpty) {
          // Sambungkan ke perangkat pertama dalam daftar
          await bluetooth
              .connect(devices[0])
              .timeout(
                Duration(seconds: 300),
                onTimeout: () {
                  throw Exception("Timeout: Gagal menghubungkan ke perangkat.");
                },
              );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Berhasil terhubung ke ${devices}')),
          );
        } else {
          print("Tidak ada perangkat terpasang yang ditemukan.");
        }
      }
    } else {
      print("Izin untuk Bluetooth tidak diberikan.");
    }
  }

  void printReceipt() async {
    // Muat gambar logo dari aset aplikasi
    final ByteData logoBytes = await rootBundle.load(
      'assets/images/digiham.jpeg',
    );
    final Uint8List logoData = logoBytes.buffer.asUint8List();
    // Cetak gambar logo terlebih dahulu
    bluetooth.printImageBytes(logoData);
    bluetooth.printNewLine();
    bluetooth.printNewLine();
    int totalKolom = 46;
    String formatToday = DateFormat("dd-MM-yyyy").format(DateTime.now());
    int baris1 = totalKolom - ('Tanggal Transaksi'.length + formatToday.length);
    int baris2 = totalKolom - ('Jenis Transaksi'.length + 'Transfer'.length);
    int baris3 =
        totalKolom - ('Nama Pengirim'.length + '${widget.namaPengirim.split(' ')[0]}'.length);
    int baris4 =
        totalKolom -
        ('Nama Penerima'.length + '${widget.namaPenerima.split(' ')[0]}'.length);
   // int baris5 = totalKolom - ('No. Rek Tujuan'.length + '${widget.noRekTujuan}'.length);
    int baris6 =
        totalKolom -
        ('Nominal Transfer'.length +
            '${formatRupiah(widget.nominal)}'.length);
    int baris7 = totalKolom - ('Berita'.length + '${widget.keterangan}'.length);

    String format1 = 'Tanggal Transaksi' + ' ' * baris1 + formatToday;
    String format2 = 'Jenis Transaksi' + ' ' * baris2 + 'Transfer';
    String format3 = 'Nama Pengirim' + ' ' * baris3 + '${widget.namaPengirim.split(' ')[0]}';
    String format4 =
        'Nama Penerima' + ' ' * baris4 + '${widget.namaPenerima.split(' ')[0]}';
    //String format5 = 'No. Rek Tujuan' + ' ' * baris5 + '${widget.noRekTujuan}';
    String format6 =
        'Nominal Transfer' +
        ' ' * baris6 +
        '${formatRupiah(widget.nominal)}';
    String format7 = 'Berita' + ' ' * baris7 + '${widget.keterangan}';

    if (await bluetooth.isConnected ?? false) {
      bluetooth.printCustom("DIGIHAM BANK", 3, 1);
      bluetooth.printNewLine();
      bluetooth.printCustom(format1, 1, 0);
      bluetooth.printCustom(format2, 1, 0);
      bluetooth.printCustom(format3, 1, 0);
      bluetooth.printCustom(format4, 1, 0);
      //bluetooth.printCustom(format5, 1, 0);
      bluetooth.printCustom(format6, 1, 0);
      bluetooth.printCustom(format7, 1, 0);
      bluetooth.printNewLine();
      bluetooth.printCustom("Rekayasa Perangkat Lunak", 1, 1);
      bluetooth.printNewLine();
      bluetooth.paperCut();
    } else {
      printReceipt();
  }
  }

  @override
  Widget build(BuildContext context) {
     // kurangi saldo global saat halaman ini dipanggil
    if (HomePage.saldo >= widget.nominal) {
      HomePage.saldo -= widget.nominal;
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
                "Rp ${widget.nominal.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),

              // Detail informasi
              RowInfo("Nama Pengirim", widget.namaPengirim),
              RowInfo("Jenis Transaksi", widget.jenisTransaksi),
              RowInfo("Nama Penerima", widget.namaPenerima),
              RowInfo("Nominal Transfer", "Rp ${widget.nominal.toStringAsFixed(0)}"),
              RowInfo("Tanggal Transfer",widget.tanggal),
              RowInfo("Keterangan", widget.keterangan.isEmpty ? "-" : widget.keterangan),
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

// class TransferSuccessPage extends StatefulWidget {
//   final String namaPengirim;
//   final String jenisTransaksi;
//   final String namaPenerima;
//   final double nominal;
//   final String tanggal;
//   final String keterangan;

//   const TransferSuccessPage({
//     super.key,
//     required this.namaPengirim,
//     required this.jenisTransaksi,
//     required this.namaPenerima,
//     required this.nominal,
//     required this.tanggal,
//     required this.keterangan,
//   });

  

//   @override
//   Widget build(BuildContext context) {
   
//   }
// }

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
