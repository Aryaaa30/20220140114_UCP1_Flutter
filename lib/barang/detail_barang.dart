import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:session5_ucp1/home_page.dart'; // Tambahkan ini

class DetailDataPage extends StatelessWidget {
  final String tanggal;
  final String jenisTransaksi;
  final String jenisBarang;
  final int jumlahBarang;
  final int hargaSatuan;

  const DetailDataPage({
    super.key,
    required this.tanggal,
    required this.jenisTransaksi,
    required this.jenisBarang,
    required this.jumlahBarang,
    required this.hargaSatuan,
  });

  @override
  Widget build(BuildContext context) {
    final int totalHarga = jumlahBarang * hargaSatuan;
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFCF6F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.2),
                ),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check, color: Colors.white, size: 48),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Data Berhasil Disimpan',
                style: TextStyle(
                  fontSize: 22, // diperbesar
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              buildDetailRow('Tanggal', tanggal),
              const Divider(),
              buildDetailRow('Jenis Transaksi', jenisTransaksi),
              const Divider(),
              buildDetailRow('Jenis Barang', jenisBarang),
              const Divider(),
              buildDetailRow('Jumlah Barang', jumlahBarang.toString()),
              const Divider(),
              buildDetailRow(
                'Harga Satuan',
                currencyFormat.format(hargaSatuan),
              ),
              const Divider(),
              buildDetailRow('Total Harga', currencyFormat.format(totalHarga)),
              const SizedBox(
                height: 100,
              ), // Spacer diganti supaya tombolnya naik sedikit
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => HomePage(
                              username: 'User',
                            ), // Ganti username sesuai kebutuhan
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Selesai',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ), // diperbesar
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20, // diperbesar
            fontWeight: FontWeight.bold,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 16, // diperbesar
            ),
          ),
        ),
      ],
    ),
  );
}
