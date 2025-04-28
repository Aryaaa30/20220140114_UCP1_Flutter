import 'package:flutter/material.dart';
import 'package:session5_ucp1/home_page.dart';

class RegisterPage extends StatefulWidget {
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

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 174, 141, 80), // wheat color (krem kayu)
              Color(0xFFDEB887), // burlywood (coklat muda kayu)
              Color(0xFF8B4513), // saddle brown (kayu coklat tua)
            ],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset('assets/logo.png', height: 250),
                        const SizedBox(height: 5),
                        const Text(
                          'DAFTAR AKUN BARU',
                          style: TextStyle(
                            fontSize: 22, // Sesuaikan dengan LoginPage
                            color: Colors.white, // Ubah warna untuk kontras
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(1, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  buildLabel("Nama Lengkap"),
                  customInputField(
                    controller: nameController,
                    label: "Masukkan Nama Lengkap",
                    icon: Icons.person,
                    validatorMsg: "Masukkan nama lengkap",
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabel("Email"),
                            customInputField(
                              controller: emailController,
                              label: "Masukkan Email",
                              icon: Icons.email,
                              validatorMsg: "Masukkan email",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabel("No HP"),
                            customInputField(
                              controller: phoneController,
                              label: "Masukkan No HP",
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validatorMsg: "Masukkan nomor HP",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabel("Password"),
                            customInputField(
                              controller: passwordController,
                              label: "Masukkan Password",
                              icon: Icons.lock,
                              obscureText: _obscurePassword,
                              validatorMsg: "Masukkan password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.brown,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabel("Konfirmasi Password"),
                            customInputField(
                              controller: confirmPasswordController,
                              label: "Masukkan Konfirmasi Password",
                              icon: Icons.lock_outline,
                              obscureText: _obscureConfirmPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Konfirmasi password wajib diisi";
                                } else if (value != passwordController.text) {
                                  return "Password tidak sama";
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.brown,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  Center(
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF8B4513,
                          ), // saddle brown
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation:
                              5, // Tambahkan efek elevasi seperti LoginPage
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        HomePage(username: nameController.text),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah memiliki akun? Silahkan',
                        style: TextStyle(
                          color: Colors.brown, // Ubah warna untuk kontras
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Login Disini',
                          style: TextStyle(
                            color: Colors.white, // Sesuaikan dengan LoginPage
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
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

  Widget customInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    String? validatorMsg,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
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
          decoration: inputStyle(label, icon, suffixIcon),
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

  InputDecoration inputStyle(
    String label,
    IconData icon, [
    Widget? suffixIcon,
  ]) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black54),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9), // Sesuaikan dengan LoginPage
      prefixIcon: Icon(icon, color: Colors.brown), // Warna ikon cokelat
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    );
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white, // Ubah warna untuk kontras
        fontSize: 16,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(color: Colors.black54, offset: Offset(1, 1), blurRadius: 2),
        ],
      ),
    );
  }
}
