import 'package:flutter/material.dart';
import 'package:tgs1_progmob/anggota_details.dart';
import 'package:tgs1_progmob/landing_page.dart';
import 'package:tgs1_progmob/add_anggota.dart';
import 'package:tgs1_progmob/typo.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

GetStorage _storage = GetStorage();

void main() {
  GetStorage _storage = GetStorage();
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  void goLogout(BuildContext context) async {
    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/logout',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      }
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    } catch (error) {
      print('Error: $error');
    }
  }

  void _getUserDetails(BuildContext context) async {
    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/user',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        final userData = _response.data['data']['user'];

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Detail Pengguna DokuSaku',
                style: headerThree,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nama: ${userData['name']}',
                    style: inputField,
                  ),
                  Text(
                    'Email: ${userData['email']}',
                    style: inputField,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tutup', style: tutup),
                ),
              ],
            );
          },
        );
      }
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    } catch (error) {
      print('Error: $error');
    }
  }

  void _getAnggotaDetails(BuildContext context) async {
    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        List<dynamic> anggotaList = _response.data['data']['anggotas'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnggotaList(anggotaList: anggotaList),
          ),
        );
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintStyle: penjelasanSearch,
                      hintText: 'Cari....',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      contentPadding: EdgeInsets.only(bottom: 19.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                _getUserDetails(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/pengguna.png'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Hai!',
                textAlign: TextAlign.left,
                style: headerBig,
              ),
              SizedBox(height: 8),
              Text(
                'Selesaikan masalah keuangan Anda dengan DokuSaku!',
                textAlign: TextAlign.left,
                style: penjelasanHome,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddAnggota(onUserAdded: (UserModel ) {  },)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 213, 221, 152),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Color.fromARGB(255, 2, 2, 2)),
                            SizedBox(width: 8),
                            Text('Anggota'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        goLogout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 194, 177, 247),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.logout, color: const Color.fromARGB(255, 0, 0, 0)),
                            SizedBox(width: 8),
                            Text('Logout',
                                style: teksButtonTwo),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Distribusi pengeluaran Anda ada di sini!',
                  textAlign: TextAlign.left,
                  style: penjelasanHome,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/diagram_lingkaran.jpeg',
                    width: 700,
                    height: 700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/home.png', width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Home', style: labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _getAnggotaDetails(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/nofilluser.png',
                      width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Anggota', style: labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/kalender.png',
                      width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Plan', style: labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/notifikasi.png',
                      width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Notifikasi', style: labelNavbar),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

