import 'package:flutter/material.dart';
import 'package:session5_ucp1/home_page.dart';
import 'package:session5_ucp1/register_page.dart';

class LoginPage extends StatefulWidget {
  // memiliki status yang bisa berubah
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png', // Ganti sesuai path logo kamu
                  height: 300,
                ),
                const SizedBox(height: 1),
                const Text(
                  'SELAMAT DATANG KEMBALI',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 12, 12, 12),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 16, 16, 16),
                    ),
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 16, 16, 16),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 249, 247, 247),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText:
                      _obscureText, //  untuk menyembunyikan/memperlihatkan password
                  style: const TextStyle(
                    color: Color.fromARGB(255, 13, 13, 13),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 5, 5, 5),
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 5, 5, 5),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility
                            : Icons
                                .visibility_off, // Menampilkan ikon mata tergantung status
                        color: const Color.fromARGB(255, 5, 5, 5),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText =
                              !_obscureText; // Mengubah status _obscureText
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
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
                        Navigator.pushReplacement(
                          // Agar tidak bisa kembali ke halaman login page
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum memiliki akun? Silahkan',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Daftar disini',
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
