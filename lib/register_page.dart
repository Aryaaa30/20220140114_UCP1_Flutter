import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  // memiliki status yang bisa berubah
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/register.png', height: 200),
                  const SizedBox(height: 10),
                  const Text(
                    'DAFTAR AKUN BARU',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Nama Lengkap
                  customInputField(
                    // untuk menghindari penulisan berulang
                    controller: nameController,
                    label: "Nama Lengkap",
                    icon: Icons.person,
                    validatorMsg: "Masukkan nama lengkap",
                  ),
                  const SizedBox(height: 10),

                  // Membuat Email dan No HP sejajar (Row)
                  Row(
                    children: [
                      Expanded(
                        child: customInputField(
                          controller: emailController,
                          label: "Email",
                          icon: Icons.email,
                          validatorMsg: "Masukkan email",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: customInputField(
                          controller: phoneController,
                          label: "No HP",
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validatorMsg: "Masukkan nomor HP",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Membuat Password dan Konfirmasi Password sejajar (Row)
                  Row(
                    children: [
                      Expanded(
                        child: customInputField(
                          controller: passwordController,
                          label: "Password",
                          icon: Icons.lock,
                          obscureText: true,
                          validatorMsg: "Masukkan password",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: customInputField(
                          controller: confirmPasswordController,
                          label: "Konfirmasi Password",
                          icon: Icons.lock_outline,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Konfirmasi password wajib diisi";
                            } else if (value != passwordController.text) {
                              return "Password tidak sama";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Tombol Register
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          193,
                          100,
                          34,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Berhasil Register!')),
                          );
                        }
                      },
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sudah punya akun
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah memiliki akun? Silahkan',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Login Disini',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi field reusable
  Widget customInputField({
    //Mengurangi duplikasi kode, menyederhanakan
    required TextEditingController
    controller, //pembuatan input dengan parameter.
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    String? validatorMsg,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: 400,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.black),
          decoration: inputStyle(label, icon),
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return validatorMsg ?? "Field wajib diisi";
                }
                return null;
              },
        ),
      ),
    );
  }

  // Fungsi dekorasi form
  InputDecoration inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    );
  }
}
