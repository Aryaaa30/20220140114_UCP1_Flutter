import 'package:flutter/material.dart';
import 'package:session5_ucp1/detail_menyapu_page.dart';

class PiketGudangPage extends StatefulWidget {
  const PiketGudangPage({super.key});

  @override
  State<PiketGudangPage> createState() => _PiketGudangPageState();
}

class _PiketGudangPageState extends State<PiketGudangPage> {
  final TextEditingController namaAnggotaController = TextEditingController(
    text: 'Admin',
  );
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController tugasPiketController = TextEditingController();

  final List<Map<String, String>> daftarTugas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F3),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Piket Gudang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            buildLabel('Nama Anggota'),
            buildInputField(namaAnggotaController, readOnly: true),
            const SizedBox(height: 16),
            buildLabel('Pilih Tanggal'),
            buildInputField(
              tanggalController,
              readOnly: true,
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
                      "${pickedDate.toLocal()}".split(' ')[0];
                }
              },
            ),
            const SizedBox(height: 16),
            buildLabel('Tugas Piket'),
            Row(
              children: [
                Expanded(child: buildInputField(tugasPiketController)),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (tugasPiketController.text.isNotEmpty) {
                      setState(() {
                        daftarTugas.add({
                          'nama': namaAnggotaController.text,
                          'tanggal': tanggalController.text,
                          'tugas': tugasPiketController.text,
                        });
                        tugasPiketController.clear();
                      });
                    }
                  },
                  child: const Text(
                    'Tambah',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildLabel(String text) {
  return Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  );
}

Widget buildInputField(
  TextEditingController controller, {
  bool readOnly = false,
  Widget? suffixIcon,
  VoidCallback? onTap,
}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    onTap: onTap,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
