import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:tgs1_progmob/tabungan/tabungan_detail.dart';

class AnggotaDatas {
  final List<Anggota> anggotaDatas;

  AnggotaDatas({required this.anggotaDatas});

  factory AnggotaDatas.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    final anggota = data?['anggotas'] as List<dynamic>?;

    return AnggotaDatas(
      anggotaDatas: anggota
              ?.map((anggotaData) =>
                  Anggota.fromJson(anggotaData as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class Anggota {
  final int id;
  final int nomor_induk;
  final String nama;
  final String alamat;
  final String tgl_lahir;
  final String telepon;
  final String? image_url;
  final int? status_aktif;
  int saldo; // Add this field for saldo

  Anggota({
    required this.id,
    required this.nomor_induk,
    required this.nama,
    required this.alamat,
    required this.tgl_lahir,
    required this.telepon,
    required this.image_url,
    required this.status_aktif,
    required this.saldo, // Initialize saldo in the constructor
  });

  factory Anggota.fromJson(Map<String, dynamic> json) {
    return Anggota(
      id: json['id'],
      nomor_induk: json['nomor_induk'],
      nama: json['nama'],
      alamat: json['alamat'],
      tgl_lahir: json['tgl_lahir'],
      telepon: json['telepon'],
      image_url: json['image_url'],
      status_aktif: json['status_aktif'],
      saldo: 0, // Default saldo to 0, it will be updated later
    );
  }
}

class ListTabungan extends StatefulWidget {
  const ListTabungan({super.key});

  @override
  State<ListTabungan> createState() => _ListTabunganState();
}

class _ListTabunganState extends State<ListTabungan> {
  AnggotaDatas? anggotaDatas;
  final _dio = Dio();
  final _storage = GetStorage();
  final _apiUrl = 'https://mobileapis.manpits.xyz/api';

  Future<void> getAnggota() async {
    try {
      final _response = await _dio.get(
        '$_apiUrl/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );
      Map<String, dynamic> responseData = _response.data;
      print(responseData);
      setState(() {
        anggotaDatas = AnggotaDatas.fromJson(responseData);
      });
      await getSaldoAnggota();
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getSaldoAnggota() async {
    if (anggotaDatas != null) {
      for (var anggota in anggotaDatas!.anggotaDatas) {
        try {
          final _response = await _dio.get(
            '$_apiUrl/saldo/${anggota.id}',
            options: Options(
              headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
            ),
          );
          Map<String, dynamic> responseData = _response.data;
          setState(() {
            anggota.saldo = responseData['data']['saldo'];
          });
        } on DioException catch (e) {
          print('${e.response} - ${e.response?.statusCode}');
        } catch (e) {
          print('Error: $e');
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAnggota();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:  Colors.blue.shade400),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Tabungan',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color:  Colors.blue.shade400,
                )),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(26, 94, 86, 149),
            ),
            child: IconButton(
              onPressed: () {
                getAnggota();
              },
              icon: Icon(
                Icons.refresh,
                size: 32,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 68),
              child:
                  anggotaDatas == null || anggotaDatas!.anggotaDatas.isEmpty
                      ? Text("Tidak ada anggota")
                      : ListView.builder(
                          itemCount: anggotaDatas!.anggotaDatas.length,
                          itemBuilder: (context, index) {
                            final anggota = anggotaDatas!.anggotaDatas[index];
                            return ListTile(
                              title: Text(anggota.nama),
                              subtitle: Row(
                                children: [
                                  Icon(Icons.wallet_sharp, size: 14),
                                  SizedBox(width: 6),
                                  Text(anggota.saldo.toString()),
                                ],
                              ),
                              leading: 
                                    SvgPicture.asset(
                                      'assets/images/user.svg',
                                      
                                      width: 60, // Set a width for the SVG image
                                      height: 60, // Set a height for the SVG image
                                    ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DetailTabungan(),
                                    settings: RouteSettings(
                                      arguments: {
                                        'id': anggota.id,
                                        'nama': anggota.nama,
                                        'saldo': anggota.saldo,
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari anggota...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
