import 'package:flutter/material.dart';
import 'package:session5_ucp1/home_page.dart';
import 'package:session5_ucp1/login_page.dart';
import 'package:session5_ucp1/piket_gudang.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {'/login': (context) => const LoginPage()},
    );
  }
}
