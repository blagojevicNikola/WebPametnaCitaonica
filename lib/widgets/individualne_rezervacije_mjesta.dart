import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/api/mjesta_service.dart';
import 'package:web_aplikacija/api/prikaz_individualnih_rezervacija_mjesta_service.dart';
import 'package:web_aplikacija/models/argumenti_prikaza_individualne_rezervacije_mjesta.dart';
import 'package:web_aplikacija/models/individualne_rezervacije_mjesta_prikaz.dart';
import 'package:web_aplikacija/models/karakteristike.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';
import 'package:web_aplikacija/widgets/individualna_rezervacija_card.dart';

import '../models/mjesto.dart';
import 'karakteristike_field.dart';

class IndividualneRezervacijeMjesta extends StatefulWidget {
  final Mjesto mjestoData;
  final Function(Mjesto, bool) funkcijaZakljucavanjaMjesta;
  IndividualneRezervacijeMjesta({
    required this.mjestoData,
    required this.funkcijaZakljucavanjaMjesta,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IndividualneRezervacijeMjestaState();
  }
}

class _IndividualneRezervacijeMjestaState
    extends State<IndividualneRezervacijeMjesta> {
  late Future<List<IndividualneRezervacijeMjestaPrikaz>> listaRezervacija;
  DioClient dioCl = DioClient();
  PrikazIndividualnihRezervacijaMjestaService
      prikazIndividualnihRezervacijaMjestaServis =
      PrikazIndividualnihRezervacijaMjestaService();
  MjestaService mjestaService = MjestaService();
  bool? mjestoJeSlobodno;
  @override
  void initState() {
    listaRezervacija =
        prikazIndividualnihRezervacijaMjestaServis.getIndRezMjesta(
            DateTime.now().subtract(const Duration(days: 20)),
            DateTime.now().add(const Duration(days: 20)),
            dioCl,
            widget.mjestoData.id!);
    mjestoJeSlobodno = widget.mjestoData.dostupno;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.18,
        right: MediaQuery.of(context).size.width * 0.18,
      ),
      child: SingleChildScrollView(
        child: Dialog(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Material(
                  borderRadius: BorderRadius.circular(17),
                  color: (mjestoJeSlobodno == false)
                      ? const Color.fromARGB(255, 190, 62, 53)
                      : const Color.fromARGB(255, 55, 155, 59),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(17),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (mjestoJeSlobodno == false)
                            ? const Text(
                                'Otključaj mjesto',
                                style: TextStyle(
                                    fontSize: 19, color: Colors.white),
                              )
                            : const Text(
                                'Zaključaj mjesto',
                                style: TextStyle(
                                    fontSize: 19, color: Colors.white),
                              )),
                    onTap: () async {
                      {
                        try {
                          bool temp = await zakljucajMjesto(!mjestoJeSlobodno!);
                          if (temp == true) {
                            widget.funkcijaZakljucavanjaMjesta(
                                widget.mjestoData, mjestoJeSlobodno!);
                            const snackBar = SnackBar(
                              duration: Duration(seconds: 2),
                              backgroundColor: Color.fromARGB(255, 52, 147, 44),
                              content: Text(
                                'Uspješno zaključano mjesto!',
                                textAlign: TextAlign.center,
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } catch (err) {
                          const snackBar = SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Color.fromARGB(255, 185, 44, 34),
                            content: Text(
                              'Greška!',
                              textAlign: TextAlign.center,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Rezervacije za mjesto broj: ${widget.mjestoData.brojMjesta}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25, color: Colors.black54),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FutureBuilder<List<IndividualneRezervacijeMjestaPrikaz>>(
                  future: listaRezervacija,
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
                        List<IndividualneRezervacijeMjestaPrikaz>? list =
                            snapshot.data?.toList();

                        for (int i = 0; i < list!.length; i++) {
                          if (list[i].vrijemeOtkazivanja != null ||
                              (list[i]
                                  .vrijemeVazenjaDo
                                  .isBefore(DateTime.now())) ||
                              list[i].vrijemePotvrde != null) {
                            list[i].vrijemeVazenjaOd = list[i]
                                .vrijemeVazenjaOd
                                .add(const Duration(days: 15));
                          }
                        }
                        list.sort((a, b) =>
                            a.vrijemeVazenjaOd.compareTo(b.vrijemeVazenjaOd));
                        return Column(
                          children: [
                            const SizedBox(height: 50),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return IndividualnaRezervacijaKorisnikaCard(
                                    indRezKorData: list[index],
                                    // index: snapshot.data![index].id,
                                    index: list[index].id,
                                    funkcijaBrisanja:
                                        obrisiIndividualnuRezervacijuKorisnika,
                                  );
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
                                'Trenutno nema rezervacija za prikazati !',
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
        )),
      ),
    );
  }

  void obrisiIndividualnuRezervacijuKorisnika(int ind) async {
    var response =
        await prikazIndividualnihRezervacijaMjestaServis.deleteRezervacija(
            mjestoId: widget.mjestoData.id!,
            dioClient: dioCl,
            rezervacijaId: ind);
    if (response.statusCode == 200 || response.statusCode == 204) {
      setState(() {
        listaRezervacija =
            prikazIndividualnihRezervacijaMjestaServis.getIndRezMjesta(
                DateTime.now().subtract(const Duration(days: 20)),
                DateTime.now().add(const Duration(days: 20)),
                dioCl,
                widget.mjestoData.id!);
      });
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Greška'),
          content: const Text('Greška prilikom brisanja !',
              style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Da'),
            ),
          ],
        ),
      );

      setState(() {
        listaRezervacija =
            prikazIndividualnihRezervacijaMjestaServis.getIndRezMjesta(
                DateTime.now().subtract(const Duration(days: 20)),
                DateTime.now().add(const Duration(days: 20)),
                dioCl,
                widget.mjestoData.id!);
      });
    }
  }

  Future<bool> zakljucajMjesto(bool dostupno) async {
    Response? odgovor = await mjestaService.zakljucajMjesto(
        dioClient: dioCl,
        dostupno: dostupno,
        individualnaSalaId: '',
        mjestoId: widget.mjestoData.id.toString());
    if (odgovor != null) {
      if (odgovor.statusCode == 200) {
        widget.mjestoData.dostupno = mjestoJeSlobodno!;
        setState(() {
          mjestoJeSlobodno = !mjestoJeSlobodno!;
        });
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
