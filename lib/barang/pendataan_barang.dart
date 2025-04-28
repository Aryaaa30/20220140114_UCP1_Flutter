import 'package:flutter/material.dart';
import 'package:session5_ucp1/barang/detail_barang.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PendataanBarangPage(),
    ),
  );
}

class PendataanBarangPage extends StatefulWidget {
  const PendataanBarangPage({super.key});

  @override
  State<PendataanBarangPage> createState() => _PendataanBarangPageState();
}

class _PendataanBarangPageState extends State<PendataanBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jumlahBarangController = TextEditingController();
  final TextEditingController hargaSatuanController = TextEditingController();

  String? selectedJenisTransaksi;
  String? selectedJenisBarang;

  final List<String> jenisTransaksiList = ['Barang Masuk', 'Barang Keluar'];
  final List<String> jenisBarangList = ['Meja', 'Kursi', 'Televisi'];

  final Map<String, int> hargaBarang = {
    'Meja': 500000,
    'Kursi': 250000,
    'Televisi': 3000000,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F3),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 139, 69, 19), // saddle brown
        title: const Text(
          'Pendataan Barang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 174, 141, 80), // wheat color
              Color(0xFFDEB887), // burlywood
              Color(0xFF8B4513), // saddle brown
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                buildLabel('Tanggal Transaksi'),
                const SizedBox(height: 8),
                buildInputField(
                  controller: tanggalController,
                  hintText: 'Tanggal Transaksi',
                  suffixIcon: const Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      tanggalController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                  isTanggal: true,
                ),
                const SizedBox(height: 16),
                buildLabel('Jenis Transaksi'),
                const SizedBox(height: 8),
                buildDropdownField(
                  label: 'Pilih Jenis Transaksi',
                  value: selectedJenisTransaksi,
                  items: jenisTransaksiList,
                  onChanged: (value) {
                    setState(() {
                      selectedJenisTransaksi = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                buildLabel('Jenis Barang'),
                const SizedBox(height: 8),
                buildDropdownField(
                  label: 'Pilih Jenis Barang',
                  value: selectedJenisBarang,
                  items: jenisBarangList,
                  onChanged: (value) {
                    setState(() {
                      selectedJenisBarang = value;
                      hargaSatuanController.text =
                          hargaBarang[value]!.toString();
                    });
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel('Jumlah Barang'),
                          const SizedBox(height: 8),
                          buildInputField(
                            controller: jumlahBarangController,
                            hintText: 'Jumlah Barang',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel('Harga Satuan'),
                          const SizedBox(height: 8),
                          buildInputField(
                            controller: hargaSatuanController,
                            hintText: 'Harga Satuan',
                            prefixText: 'Rp. ',
                            readOnly: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 139, 69, 19),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DetailDataPage(
                                  tanggal: tanggalController.text,
                                  jenisTransaksi: selectedJenisTransaksi!,
                                  jenisBarang: selectedJenisBarang!,
                                  jumlahBarang: int.parse(
                                    jumlahBarangController.text,
                                  ),
                                  hargaSatuan: int.parse(
                                    hargaSatuanController.text,
                                  ),
                                ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
}

Widget buildLabel(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.brown, // label warna coklat
    ),
  );
}

Widget buildInputField({
  required TextEditingController controller,
  required String hintText,
  bool readOnly = false,
  Widget? suffixIcon,
  VoidCallback? onTap,
  bool isTanggal = false,
  String? prefixText,
}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    onTap: onTap,
    validator: (value) {
      if (value == null || value.isEmpty) {
        if (isTanggal) {
          return 'Tanggal transaksi tidak boleh kosong!';
        } else {
          return 'Field ini tidak boleh kosong!';
        }
      }
      return null;
    },
    keyboardType:
        prefixText != null ? TextInputType.number : TextInputType.text,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      suffixIcon: suffixIcon,
      prefixText: prefixText,
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

Widget buildDropdownField({
  required String label,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    onChanged: onChanged,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    ),
    items:
        items
            .map(
              (item) =>
                  DropdownMenuItem<String>(value: item, child: Text(item)),
            )
            .toList(),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Silakan pilih $label';
      }
      return null;
    },
  );
}
