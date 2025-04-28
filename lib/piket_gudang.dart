import 'package:flutter/material.dart';
import 'package:session5_ucp1/detail_menyapu_page.dart';

class PiketGudangPage extends StatefulWidget {
  final String username;

  const PiketGudangPage({super.key, required this.username});

  @override
  State<PiketGudangPage> createState() => _PiketGudangPageState();
}

class _PiketGudangPageState extends State<PiketGudangPage> {
  final TextEditingController namaAnggotaController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController tugasPiketController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> daftarTugas = [];

  @override
  void initState() {
    super.initState();
    namaAnggotaController.text = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F3),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Piket Gudang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              buildLabel('Nama Anggota'),
              buildInputField(
                namaAnggotaController,
                readOnly: true,
                isTanggal: false,
                isTugas: false,
              ),
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
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
                },
                isTanggal: true,
                isTugas: false,
              ),
              const SizedBox(height: 16),
              buildLabel('Tugas Piket'),
              Row(
                children: [
                  Expanded(
                    child: buildInputField(
                      tugasPiketController,
                      isTanggal: false,
                      isTugas: true,
                    ),
                  ),
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
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          daftarTugas.add({
                            'nama': namaAnggotaController.text,
                            'tanggal': tanggalController.text,
                            'tugas': tugasPiketController.text,
                          });
                          tugasPiketController.clear();
                          tanggalController.clear();
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
              const SizedBox(height: 32),
              const Center(
                child: Text(
                  'Daftar Tugas Piket',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              daftarTugas.isEmpty
                  ? const Center(child: Text('Belum ada Data'))
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: daftarTugas.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => DetailMenyapuPage(
                                    nama: daftarTugas[index]['nama'] ?? '',
                                    tanggal:
                                        daftarTugas[index]['tanggal'] ?? '',
                                    tugas: daftarTugas[index]['tugas'] ?? '',
                                  ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              daftarTugas[index]['tugas'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            ],
          ),
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
  bool isTanggal = false,
  bool isTugas = false,
}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    onTap: onTap,
    validator: (value) {
      if (value == null || value.isEmpty) {
        if (isTanggal) {
          return 'Tanggal tidak boleh kosong!';
        } else if (isTugas) {
          return 'Tugas tidak boleh kosong!';
        }
      }
      return null;
    },
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
