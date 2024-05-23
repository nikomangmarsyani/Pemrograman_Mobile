import 'package:flutter/material.dart';
import 'package:tgs1_progmob/landing_page.dart';
import 'package:tgs1_progmob/register_page.dart';
import 'package:tgs1_progmob/login_page.dart';
import 'package:tgs1_progmob/home_page.dart';
import 'package:tgs1_progmob/add_anggota.dart';
import 'package:tgs1_progmob/typo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Mengatur halaman awal (bisa juga menggunakan home)
      routes: {
        '/': (context) => HomeScreen(), // Halaman awal
        '/utama': (context) => LandingPage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/tambahanggota': (context) => AddAnggota(onUserAdded: (UserModel ) {  },),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 143,
                    height: 143,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: Text(
                    'Aplikasi Simpan Pinjam Terkini',
                    textAlign: TextAlign.center,
                    style: penjelasanOne,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/utama'); // Navigasi ke halaman Page1
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 50.0),
                  child: Text('Lanjut', style: teksKembaliLanjut),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
