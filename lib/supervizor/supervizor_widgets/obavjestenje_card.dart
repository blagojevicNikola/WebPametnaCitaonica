import 'package:flutter/material.dart';
import 'package:web_aplikacija/supervizor/supervizor_home_page.dart';
import '../../api/dio_client.dart';
import '../pages/slanje_notifikacija.dart';

import '../supervizor_models/obavjestenje.dart';

class ObavjestenjeCard extends StatelessWidget {
  final int index;
  final Obavjestenje obavjestenjeData;
  final Function(int) funkcijaBrisanja;
  final Function() funkcijaOsvjezavanja;

  const ObavjestenjeCard(
      {required this.index,
      required this.obavjestenjeData,
      required this.funkcijaBrisanja,
      required this.funkcijaOsvjezavanja,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black26,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 10),
              child: Text(
                obavjestenjeData.naslov,
                style: TextStyle(fontSize: 30, color: Colors.white),
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 10),
              child: Text(
                obavjestenjeData.tekstNotifikacije,
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
          /* Padding(
          padding: const EdgeInsets.only(
              left: 10, right: 10, top: 15, bottom: 10),
          child: Text('${obavjestenjeData.idObavjestenja}')),*/
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '\n\nVrijeme : ${obavjestenjeData.vrijemeSlanja!.hour < 10 ? '0${obavjestenjeData.vrijemeSlanja!.hour}' : obavjestenjeData.vrijemeSlanja!.hour}'
                ':${obavjestenjeData.vrijemeSlanja!.minute < 10 ? '0${obavjestenjeData.vrijemeSlanja!.minute}' : obavjestenjeData.vrijemeSlanja!.minute}'
                ':${obavjestenjeData.vrijemeSlanja!.second < 10 ? '0${obavjestenjeData.vrijemeSlanja!.second}' : obavjestenjeData.vrijemeSlanja!.second}'
                '       Datum: ${obavjestenjeData.vrijemeSlanja!.day < 10 ? '0${obavjestenjeData.vrijemeSlanja!.day}' : obavjestenjeData.vrijemeSlanja!.day}'
                '.'
                '${obavjestenjeData.vrijemeSlanja!.month < 10 ? '0${obavjestenjeData.vrijemeSlanja!.month}' : obavjestenjeData.vrijemeSlanja!.month}'
                '.'
                '${obavjestenjeData.vrijemeSlanja!.year}.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
          Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 243, 103, 93),
                    onPrimary: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    minimumSize: const Size(100, 40), //////// HERE
                  ),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Obavještenje'),
                        content: const Text(
                            'Da li ste sigurni da želite obrisati ovo obavještenje?',
                            style: TextStyle(fontSize: 20)),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              funkcijaBrisanja(index);

                              /*Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));*/
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
                  child: const Text('Obriši', style: TextStyle(fontSize: 20)),
                ),
              )),
        ]));
  }
}
