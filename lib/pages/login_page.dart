// ignore_for_file: deprecated_member_use, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/auth_service.dart';
import 'package:web_aplikacija/main.dart';
import 'package:web_aplikacija/pages/zaboravljena_lozinka_page.dart';

import '../api/dio_client.dart';
import '../supervizor/supervizor_home_page.dart';

//import 'Registracija.dart';
//import 'ZaboravljenaLozinka.dart';

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

String lozinkaLogin = '', emailLogin = '';
String izbor = 'Administrator';

class _LoginDemoState extends State<LoginDemo> {
  //late Future<Korisnik> test;
  AuthService authService = AuthService();
  DioClient dioCL = DioClient();

  @override
  Widget build(BuildContext context) {
    double visina = MediaQuery.of(context).size.height;

    String dropdownValue = 'Administrator';
    var items = ['Administrator', 'Supervizor'];

    return Scaffold(
      backgroundColor: const Color(0xFFD6F4F4),
      body: SingleChildScrollView(
        //child: SizedBox(
        // height: visina,
        child: Container(
          // height: visina,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFD6F4F4),
                Color(0xFFD6F4F4),
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF0961AF),
                          Color(0xFF27AEF7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(0)),
                  height: 80,
                  child: const Text(
                      'KONTROLNA I UPRAVLJAČKA TABLA PAMETNE ČITAONICE',
                      maxLines: 1,
                      style: TextStyle(fontSize: 35, color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: Center(
                  child: SizedBox(
                    width: 280,
                    height: 180,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset(
                      'assets/images/pametni_skoba.png',
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF0961AF),
                        Color(0xFF27AEF7),
                        //Color(0xAAFFFFFF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                width: 320,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.blue[600],
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                    ),
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    onChanged: (changedValue) {
                      izbor = changedValue.toString();
                      dropdownValue = changedValue.toString();
                      setState(() {
                        dropdownValue;
                      });
                    },
                    value: dropdownValue,
                    elevation: 16,
                    //style: const TextStyle(color: Colors.white),
                    /*underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),*/
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: items,
                        child: Text(items,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: SizedBox(
                  width: 320,
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),

                  child: TextFormField(
                    onChanged: (text) {
                      emailLogin = text;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.blue[700]),
                        fillColor: const Color(0xAAFFFFFF),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Korisničko ime',
                        hintText: 'Unesite korisničko ime'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 0, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 320,
                  child: TextFormField(
                    onChanged: (text) {
                      lozinkaLogin = text;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                        fillColor: const Color(0xAAFFFFFF),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Lozinka',
                        hintText: 'Unesite lozinku'),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 320,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF0961AF),
                        Color(0xFF27AEF7),
                        //Color(0xAAFFFFFF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () async {
                    if (emailLogin.isEmpty
                        //||
                        //  !isEmail(emailLogin) ||
                        //lozinkaLogin.length < 8
                        ) {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Neispravan unos'),
                                content: const Text(
                                    'Unijeli ste neispravan email ili lozinku !'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    } else {
                      if (izbor == 'Administrator') {
                        try {
                          var response = await authService.postLogin(
                              dioCL, emailLogin, lozinkaLogin);
                          if (response != null) {
                            if (response.statusCode == 201 &&
                                response.data['uloga'] == 'ADMIN') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MyHomePage(
                                      title: 'Administratorska App'),
                                ),
                              );
                            }
                          }
                        } on DioError catch (err) {
                          if (err.response != null) {
                            if (err.response!.statusCode == 403) {
                              const snackBar = SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 185, 44, 34),
                                content: Text(
                                  'Pogresno korisnicko ime/lozinka. Pokušaj ponovo!',
                                  textAlign: TextAlign.center,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        } catch (err) {
                          const snackBar = SnackBar(
                            backgroundColor: Color.fromARGB(255, 185, 44, 34),
                            content: Text(
                              'Greška!',
                              textAlign: TextAlign.center,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else if (izbor == 'Supervizor') {
                        var response = await authService.postLogin(
                            dioCL, emailLogin, lozinkaLogin);
                        if (response != null) {
                          if (response.statusCode == 201 &&
                              response.data['uloga'] == 'SUPERVIZOR') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SupervizorHomePage(
                                          title: 'Supervizorska App',
                                          supervizorId: response.data['id'],
                                          citaonicaId:
                                              response.data['citaonicaId'],
                                        )));
                          }
                        }
                      }
                    }
                  },
                  child: const Text(
                    'Prijavi se',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ZaboravljenaLozinka()));
                },
                child: Text(
                  'Zaboravili ste lozinku?',
                  style: TextStyle(color: Colors.blue[800], fontSize: 15),
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
