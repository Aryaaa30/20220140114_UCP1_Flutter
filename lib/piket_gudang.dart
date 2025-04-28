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
}
