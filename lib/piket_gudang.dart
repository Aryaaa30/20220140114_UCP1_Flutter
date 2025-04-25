import 'package:flutter/material.dart';
import 'package:session5_ucp1/detail_menyapu_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController makananController = TextEditingController();
  final TextEditingController minumanController = TextEditingController();
  final TextEditingController tugasController = TextEditingController();
  final TextEditingController jumlahMinumanController = TextEditingController();
  int totalHarga = 0;

  void calculateTotalPrice() {
    int jumlahMakanan = int.tryParse(tugasController.text) ?? 0;
    int jumlahMinuman = int.tryParse(jumlahMinumanController.text) ?? 0;

    setState(() {
      totalHarga = (jumlahMakanan * 32000) + (jumlahMinuman * 5000);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD2691E), Color(0xFF3E2723)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Text(
                  'Piket Gudang',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/order.png', // Ganti sesuai logo kamu
                  height: 200,
                ),
                const SizedBox(height: 40),
                buildInputField('Admin', makananController),
                const SizedBox(height: 16),
                buildInputField('Pilih Tanggal', minumanController),
                const SizedBox(height: 16),
                buildInputField('Tugas Piket', tugasController),
                const SizedBox(height: 16),
                const SizedBox(height: 40),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 193, 100, 34),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        calculateTotalPrice();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DetailOrderPage(
                                  jumlahMakanan: tugasController.text,
                                  jumlahMinuman: jumlahMinumanController.text,
                                  makanan: makananController.text,
                                  minuman: minumanController.text,
                                  totalHarga: totalHarga,
                                ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Tambah',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
    String label,
    TextEditingController controller, {
    bool isNumeric = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
