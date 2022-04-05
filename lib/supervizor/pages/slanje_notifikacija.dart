import 'dart:io';

import 'package:flutter/material.dart';
import '../../api/dio_client.dart';
import '../supervizor_models/obavjestenje.dart';
import 'package:dio/dio.dart';
import 'package:web_aplikacija/supervizor/supervizor_models/obavjestenje.dart';
import 'package:web_aplikacija/api/obavjestenje_service.dart';

import '../supervizor_widgets/obavjestenje_card.dart';

class SlanjeNotifikacija extends StatefulWidget {
  const SlanjeNotifikacija({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SlanjeNotifikacijaState();
  }
}

ObavjestenjeService obavjService = ObavjestenjeService();

class _SlanjeNotifikacijaState extends State<SlanjeNotifikacija> {
  Obavjestenje obavjestenje = Obavjestenje(naslov: '', tekstNotifikacije: '');
  DioClient dioCL = DioClient();

  @override
  Widget build(BuildContext context) {
    //double visina = MediaQuery.of(context).size.height;
    //print(visina);
    //int brojElemenata = 0;
    //print(brojElemenata);
    return SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          color: const Color(0xFFD6F4F4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    top: 20),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(50)),
                child: Column(
                  children: [
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02,
                          top: 15,
                          bottom: 10),
                      child: TextFormField(
                        onChanged: (text) {
                          obavjestenje.naslov = text;
                        },
                        decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.email, color: Colors.blue[700]),
                            fillColor: const Color(0xAAFFFFFF),
                            filled: true,
                            border: const OutlineInputBorder(),
                            //labelText: 'Naslov',
                            labelStyle: TextStyle(color: Colors.grey[700]),
                            hintText: 'Unesite naslov obavještenja'),
                      ),
                    ),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02,
                          top: 15,
                          bottom: 10),
                      child: TextFormField(
                        maxLines: 10,
                        onChanged: (text) {
                          obavjestenje.tekstNotifikacije = text;
                        },
                        decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                            fillColor: const Color(0xAAFFFFFF),
                            filled: true,
                            border: const OutlineInputBorder(),
                            //labelText: 'Tekst obavještenja',
                            labelStyle: TextStyle(color: Colors.grey[700]),
                            hintText: 'Unesite tekst obavještenja'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          //left: MediaQuery.of(context).size.width * 0.30,
                          // right: MediaQuery.of(context).size.width * 0.30,
                          top: 15,
                          bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 129, 189, 238),
                            onPrimary: Colors.white,
                            shadowColor: Colors.greenAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            minimumSize: const Size(200, 60), //////// HERE
                          ),
                          child: const Text('Objavi',
                              style: TextStyle(fontSize: 30)),
                          onPressed: () {
                            if (obavjestenje.naslov.isEmpty ||
                                obavjestenje.tekstNotifikacije.isEmpty) {
                              // print(obavjestenje.naslov);
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Dodavanje obavjestenja'),
                                  content:
                                      const Text('Morate popuniti sva polja !'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                        );
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              kreirajObavjestenje();
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Dodavanje obavjestenja'),
                                  content: const Text(
                                      'Uspjesno ste postavili obavještenje !'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                        );
                                        setState(() {});
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Divider(
                height: 80,
                color: Color.fromARGB(255, 177, 211, 240),
                thickness: 2,
                indent: 18,
                endIndent: 18,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.18,
                      //right: 0,
                      top: 50,
                      bottom: 0),
                  child: Container(
                      child: const Text('Lista obavještenja za ovu čitaonicu',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 30)))),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.18,
                      //right: MediaQuery.of(context).size.width * 0.18,
                      top: 20,
                      bottom: 0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 129, 189, 238)),
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text('Osvježi listu',
                          style: TextStyle(fontSize: 20)))),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.18,
                    right: MediaQuery.of(context).size.width * 0.18,
                    top: 0,
                    bottom: 10),
                child: FutureBuilder<List<Obavjestenje>>(
                    future: obavjService.getObavjestenja(dioCL, '3', '4'),
                    initialData: null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                            height: 120,
                            width: 120,
                            child: Center(child: CircularProgressIndicator()));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData &&
                            snapshot.data.toString() != '[]') {
                          //print(snapshot.data);
                          List<Obavjestenje>? list = snapshot.data?.toList();
                          list!.sort((a, b) =>
                              b.vrijemeSlanja!.compareTo(a.vrijemeSlanja!));
                          //brojElemenata = list.length;
                          // print(brojElemenata);
                          return Column(
                            children: [
                              const SizedBox(height: 50),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ObavjestenjeCard(
                                        list[index], refreshPage);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 40,
                                        width: 40,
                                      ),
                                  itemCount: snapshot.data!.length),
                              const SizedBox(height: 40),
                            ],
                          );
                        } else {
                          return Center(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: 300,
                                child: const Text(
                                  'Trenutno nema obavještenja za prikazati !',
                                  style: TextStyle(fontSize: 30),
                                )),
                          );
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    }),
              ),
            ],
          ),
        ));
  }

  void kreirajObavjestenje() {
    obavjService.createObavjestenje(
        dioClient: dioCL,
        obavjestenjeInfo: Obavjestenje(
            naslov: obavjestenje.naslov,
            tekstNotifikacije: obavjestenje.tekstNotifikacije),
        supervizorId: '4',
        citaonicaId: '3');
  }

  void refreshPage() {
    setState(() {});
  }
}
