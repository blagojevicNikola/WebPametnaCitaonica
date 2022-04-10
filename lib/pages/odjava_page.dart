import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/api/odjava_admin_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OdjavaPage extends StatefulWidget {
  const OdjavaPage({Key? key}) : super(key: key);

  @override
  _OdjavaPageState createState() => _OdjavaPageState();
}

OdjavaService odjavaService = OdjavaService();

class _OdjavaPageState extends State<OdjavaPage> {
  //late Future<Korisnik> test;
  DioClient dioCL = DioClient();

  @override
  Widget build(BuildContext context) {
    //double visina = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 35, 128, 209),
                Color.fromARGB(255, 226, 226, 226),
              ],
            ),
            borderRadius: BorderRadius.circular(10)),
        height: 100,
        width: MediaQuery.of(context).size.width,
        // color: const Color.fromARGB(255, 132, 186, 230),
        child: InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Odjava'),
                  content: const Text(
                      'Da li ste sigurni da se želite odjaviti?',
                      style: TextStyle(fontSize: 20)),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Odjava'),
                            content: const Text('Uspješno ste se odjavili !'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  Response? response;
                                  response = await odjaviSe();
                                  if (response != null) {
                                    if (response.statusCode == 201) {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      pref.clear();
                                      Navigator.popUntil(
                                          context, ModalRoute.withName("/"));
                                    }
                                  }
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Da'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Ne'),
                      child: const Text('Ne'),
                    ),
                  ],
                ),
              );
            },
            child: const ListTile(
                leading: Icon(Icons.logout, color: Colors.white, size: 35),
                title: Text('Odjava', style: TextStyle(color: Colors.white)))),
      ),
    );
  }

  Future<Response?> odjaviSe() async {
    var response = await odjavaService.createOdjava(dioClient: dioCL);
    return response;
  }
}
