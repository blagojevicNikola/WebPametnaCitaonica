import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_aplikacija/api/individualne_sale_service.dart';
import 'package:web_aplikacija/models/argumenti_supervizorske_izmjene_individualne_sale.dart';
import 'package:web_aplikacija/models/clanarina.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';
import 'package:web_aplikacija/models/mjesto.dart';
import 'package:web_aplikacija/supervizor/supervizor_home_page.dart';
import 'package:web_aplikacija/widgets/supervizorsko_mjesto_widget.dart';

import '../../api/dio_client.dart';
import '../../api/mjesta_service.dart';

import '../../main.dart';
import '../../models/individualna_sala.dart';

class SupervizorskiPregledIndividualneSalePage extends StatefulWidget {
  //final List<Mjesto> listaPostojecihMjesta;
  final ArgSupervizorskeIzmjeneIndividualneSale argumenti;
  const SupervizorskiPregledIndividualneSalePage(
      {Key? key, required this.argumenti})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SupervizorskiPregledIndividualneSalePageState();
  }
}

class _SupervizorskiPregledIndividualneSalePageState
    extends State<SupervizorskiPregledIndividualneSalePage> {
  Uint8List? slika;
  MjestaService mjestaService = MjestaService();
  late final Future<List<Mjesto>> listaPostojecihMjesta;
  late TextEditingController _nazivSaleController;
  IndividualneSaleService individualneSaleService = IndividualneSaleService();
  DioClient dioCL = DioClient();
  late Future<List<dynamic>> odgovorServera;

  @override
  void initState() {
    super.initState();
    print('$citaonicaIdGlobal');
    odgovorServera = Future.wait([
      dohvatiSliku(),
      mjestaService.getMjesta(
          dioCL, widget.argumenti.individualnaSalaId.toString())
    ]);
    _nazivSaleController =
        TextEditingController(text: widget.argumenti.nazivIndividualneSale);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.center,
              child: TextButton(
                child: const Text('Nazad'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(width: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Row(
                  children: [
                    const Text('Naziv sale: '),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _nazivSaleController,
                        style: const TextStyle(fontSize: 19, height: 1.1),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        FutureBuilder<List<dynamic>>(
            future: odgovorServera,
            initialData: null,
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                    height: 120,
                    width: 120,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('ERROR',
                          style: TextStyle(color: Colors.red, fontSize: 25)));
                } else if (snapshot.hasData) {
                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.memory(
                          snapshot.data![0],
                        ),
                      ),
                      for (var item in snapshot.data![1])
                        Positioned(
                          left: item.pozicija.x * getSirinaSlike(),
                          top: item.pozicija.y * getVisinaSlike(),
                          child: SupervizorskoMjestoWidget(
                            mjestoData: item,
                            index: item.brojMjesta,
                            velicina: sqrt((item.velicina *
                                    getKoeficijentVelicineMjesta()) /
                                100),
                            funkcijaZakljucavanjaMjesta: zakljucajMjesto,
                          ),
                        ),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: TextButton(
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                  const Size(120, 40),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 87, 182, 93),
                                ),
                                overlayColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 112, 218, 116))),
                            child: const Text(
                              'Sacuvaj',
                              style:
                                  TextStyle(fontSize: 21, color: Colors.white),
                            ),
                            onPressed: () async {
                              if (ispravneInformacijeSale()) {
                                final odgovor =
                                    await azurirajIndividualnuSalu();
                                if (odgovor == true) {
                                  Navigator.of(context).pop();
                                } else {
                                  const snackBar = SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 185, 44, 34),
                                    content: Text(
                                      'Greska pri izmjeni sale!',
                                      textAlign: TextAlign.center,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                          ))
                    ],
                  );
                } else {
                  return const Center(child: Text('Greska'));
                }
              } else {
                return const Center(child: Text('Greska'));
              }
            }),
      ],
    ));
  }

  bool ispravneInformacijeSale() {
    if (_nazivSaleController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void zakljucajMjesto(Mjesto m, bool dostupno) {
    setState(() {
      m.dostupno = dostupno;
    });
  }

  Future<bool> azurirajIndividualnuSalu() async {
    IndividualnaSala? odgovor =
        await individualneSaleService.azurirajIndividualnuSalu(
      dioClient: dioCL,
      individualnaSalaData: IndividualnaSala(
          id: widget.argumenti.individualnaSalaId,
          naziv: _nazivSaleController.text.toString(),
          brojMjesta: widget.argumenti.brojMjestaUSali,
          clanarine: <Clanarina>[],
          karakteristike: <KarakteristikeSale>[]),
      citaonicaId: widget.argumenti.citaonicaId.toString(),
      individualnaSalaId: widget.argumenti.individualnaSalaId.toString(),
    );
    if (odgovor != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Uint8List> dohvatiSliku() async {
    http.Response odgovor = await http.get(Uri.parse(
        'https://localhost:8443/api/v1/individualne-sale/${widget.argumenti.individualnaSalaId.toString()}/slika/'));
    if (odgovor.statusCode == 200) {
      return odgovor.bodyBytes;
    } else {
      return Uint8List(0);
    }
  }

  double getKoeficijentVelicineMjesta() {
    RenderBox? renderBoxNavRail = supervizorNavigationRailKey.currentContext!
        .findRenderObject() as RenderBox?;
    if (renderBoxNavRail != null) {
      double widthOfImage =
          MediaQuery.of(context).size.width - renderBoxNavRail.size.width;
      return (widthOfImage * 0.5625) * widthOfImage;
    } else {
      print('dddd');
      return 0;
    }
  }

  double getSirinaSlike() {
    RenderBox? renderBoxNavRail = supervizorNavigationRailKey.currentContext!
        .findRenderObject() as RenderBox?;

    if (renderBoxNavRail != null) {
      return MediaQuery.of(context).size.width - renderBoxNavRail.size.width;
    } else {
      print('dddd');
      return 0;
    }
  }

  double getVisinaSlike() {
    RenderBox? renderBoxNavRail = supervizorNavigationRailKey.currentContext!
        .findRenderObject() as RenderBox?;

    if (renderBoxNavRail != null) {
      return (MediaQuery.of(context).size.width - renderBoxNavRail.size.width) *
          0.5625;
    } else {
      print('dddd');
      return 0;
    }
  }
}
