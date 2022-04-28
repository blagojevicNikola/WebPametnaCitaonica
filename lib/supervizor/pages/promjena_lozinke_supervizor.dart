// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/api/promjena_lozinke_service.dart';
import 'package:web_aplikacija/models/promjena_lozinke.dart';

import '../../pages/login_page.dart';
//import 'login_page.dart';

class PromjenaLozinkeSupervizorPage extends StatefulWidget {
  const PromjenaLozinkeSupervizorPage({Key? key}) : super(key: key);

  @override
  _PromjenaLozinkeSupervizorPageState createState() =>
      _PromjenaLozinkeSupervizorPageState();
}

class _PromjenaLozinkeSupervizorPageState
    extends State<PromjenaLozinkeSupervizorPage> {
  String unosLozinka = '', novaLozinka = '', novaLozinkaPotvrda = '';

  DioClient dioCl = DioClient();
  PromjenaLozinkeService promjenaLozinkeService = PromjenaLozinkeService();
  PromjenaLozinke promjenaLozinkeInfo =
      PromjenaLozinke(staraLozinka: '', novaLozinka: '');
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView(
        // child: Column(
        children: <Widget>[
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 10),
            child: TextFormField(
              obscureText: true,
              onChanged: (text) {
                unosLozinka = text;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(),
                  labelText: 'Trenutna lozinka',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  hintText: 'Unesite vašu trenutnu lozinku'),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 10),
            child: TextFormField(
              obscureText: true,
              onChanged: (text) {
                novaLozinka = text;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.blue[700]),
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(),
                  labelText: 'Nova lozinka',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  hintText: 'Unesite vašu novu loznku'),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 10),
            child: TextFormField(
              obscureText: true,
              onChanged: (text) {
                novaLozinkaPotvrda = text;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.blue[700]),
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(),
                  labelText: 'Potvrda nove lozinka',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  hintText: 'Ponovo unesite vašu novu loznku'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 10),
            //Kada se prilikom registracije stisne dugme sacuvaj, prvo se provjerava da li su uneseni podaci u sva polja
            //Nakon toga se provjerava da li je duzina lozinke minimum 8 karakera
            //Nakon toga da li se poklapaju lozinke i ako je sve to ispunjeno onda se uspjesno registruje
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue[700]),
              onPressed: () async {
                if (unosLozinka.isEmpty ||
                    novaLozinka.isEmpty ||
                    novaLozinkaPotvrda.isEmpty) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Neispravan unos'),
                      content: const Text('Morate popuniti sve podatke'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (novaLozinka.length < 8) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Neispravna nova lozinka'),
                      content: const Text(
                          'Dužina nove lozinke mora biti 8 ili vise karaktera !'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (novaLozinka != novaLozinkaPotvrda) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Neispravne lozinke'),
                      content: const Text('Nove lozinke se ne poklapaju !'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  promjenaLozinkeInfo.staraLozinka = unosLozinka;
                  promjenaLozinkeInfo.novaLozinka = novaLozinkaPotvrda;
                  promjeniLozinku();
                }
              },
              child: const Text(
                'Sačuvaj',
                textScaleFactor: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void promjeniLozinku() async {
    try {
      var response = await promjenaLozinkeService.promjeniLozinku(
          dioClient: dioCl, promjenaLozinkeData: promjenaLozinkeInfo);

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Uspješna promjena lozinke'),
            content: const Text('Čestitamo, uspješno ste promjenili lozinku !'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "login", (r) => false);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (err) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Greška'),
          content: const Text('Pogrešno uneseni podaci za promjenu lozinke !'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                var nav = Navigator.of(context);
                //Navigator.pop(context, 'OK');
                nav.pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
