import 'package:flutter/material.dart';
import 'package:tgs1_progmob/main.dart';
import 'package:tgs1_progmob/page2.dart';
import 'package:tgs1_progmob/page3.dart';
import 'package:tgs1_progmob/typo.dart';

void main() {
  runApp(const Page1());
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginRegister();
  }
}

class LoginRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  'Andalkan DokuSaku untuk Proses Simpan Pinjam yang Efektif',
                  textAlign: TextAlign.center,
                  style: headerOne,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 45.0, right: 45.0),
                child: Text(
                  'Beralihah ke DokuSaku untuk simpan pinjam yang aman, mudah, dan cepat!',
                  textAlign: TextAlign.center,
                  style: penjelasanOne,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Page2()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF131F20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  fixedSize: Size(320, 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/user.png',
                        width: 14,
                        height: 14,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Buat Akun Baru',
                        style: teksButtonOne.copyWith(color: Color(0xFFE9EBEB)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 241, 249, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  fixedSize: Size(320, 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 14,
                        height: 14,
                      ),
                      SizedBox(width: 8),
                      Text('Lanjutkan dengan Google', style: teksButtonOne),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 45.0, right: 45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sudah punya akun? ',
                        textAlign: TextAlign.center, style: penjelasanOne),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Page3()),
                        );
                      },
                      child: Text('Masuk',
                          textAlign: TextAlign.center, style: teksMasuk),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, top: 50.0),
                child: Text('Kembali', style: teksKembaliLanjut),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
