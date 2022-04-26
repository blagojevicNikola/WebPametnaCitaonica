import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_aplikacija/api/individualne_sale_service.dart';
import 'package:web_aplikacija/main.dart';
import 'package:web_aplikacija/models/argumenti_izmjene_individualne_sale.dart';
import 'package:web_aplikacija/models/individualna_sala.dart';

import '../api/dio_client.dart';
import '../api/mjesta_service.dart';
import '../models/mjesto.dart';
import '../models/pozicijaXY.dart';
import '../widgets/postojece_mjesto_widget.dart';
import 'package:web_aplikacija/widgets/mjesto_widget.dart';

class IzmjenaIndividualneSalePage extends StatefulWidget {
  //final List<Mjesto> listaPostojecihMjesta;
  final ArgumentiIzmjeneIndividualneSale argumenti;
  const IzmjenaIndividualneSalePage({Key? key, required this.argumenti})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IzmjenaIndividualneSalePageState();
  }
}

class _IzmjenaIndividualneSalePageState
    extends State<IzmjenaIndividualneSalePage> {
  MjestaService mjestaService = MjestaService();
  IndividualneSaleService individualneSaleService = IndividualneSaleService();
  late final Future<List<Mjesto>> listaPostojecihMjesta;
  List<Mjesto> listaMjesta = <Mjesto>[];
  final ugaoController = TextEditingController();
  final velicinaController = TextEditingController();
  final qrCodeController = TextEditingController();
  final brojController = TextEditingController();
  late final nazivSaleController;
  DioClient dioCL = DioClient();
  GlobalKey rowKey = GlobalKey();
  late Future<List<dynamic>> odgovorServera;

  @override
  void initState() {
    super.initState();
    // listaPostojecihMjesta =
    //     mjestaService.getMjesta(dioCL, widget.individualnaSalaId.toString());
    odgovorServera = Future.wait([
      dohvatiSliku(),
      mjestaService.getMjesta(
          dioCL, widget.argumenti.individualnaSalaData.id.toString())
    ]);
    nazivSaleController = TextEditingController(
        text: widget.argumenti.individualnaSalaData.naziv);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Row(
          key: rowKey,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('Nazad'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Dodaj sliku'),
              onPressed: () {
                print(getKoeficijentVelicineMjesta());
              },
            ),
            TextButton(
              child: const Text('Ukloni sliku'),
              onPressed: () {},
            ),
            TextButton(
                child: const Text('Dodaj mjesto'),
                onPressed: () {
                  if (!ispravneInformacijeMjesta()) {
                    const snackBar = SnackBar(
                      backgroundColor: Color.fromARGB(255, 185, 44, 34),
                      content: Text(
                        'Pogresne informacije mjesta!',
                        textAlign: TextAlign.center,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    dodajMjesto();
                  }
                }),
            const SizedBox(width: 30),
            Row(
              children: [
                const Text('Velicina: '),
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: velicinaController,
                    style: const TextStyle(fontSize: 19, height: 1.1),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                const Text('Ugao: '),
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: ugaoController,
                    style: const TextStyle(fontSize: 19, height: 1.1),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                const Text('QR code: '),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: qrCodeController,
                    style: const TextStyle(fontSize: 19, height: 1.1),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                const Text('Broj: '),
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: brojController,
                    style: const TextStyle(fontSize: 19, height: 1.1),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Naziv sale: '),
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: nazivSaleController,
                    style: const TextStyle(fontSize: 19, height: 1.1),
                  ),
                ),
              ],
            )
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
                  return Text('Error  : ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Image.memory(
                            snapshot.data![0],
                          )),
                      for (var item in snapshot.data![1])
                        Positioned(
                          left: item.pozicija.x * getSirinaSlike(),
                          top: item.pozicija.y * getVisinaSlike(),
                          child: PostojeceMjestoWidget(
                            index: item.oznakaSale,
                            velicina: sqrt((item.velicina *
                                    getKoeficijentVelicineMjesta()) /
                                100),
                            ugao: item.ugao,
                          ),
                        ),
                      for (var item in listaMjesta)
                        Positioned(
                          left: item.pozicija.x,
                          top: item.pozicija.y,
                          child: MjestoWidget(
                            index: listaMjesta.indexOf(item),
                            onDragEnd: onDragEnd,
                            mjestoDat: item,
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
                              if (spremnoZaSlanje(snapshot.data![1])) {
                                try {
                                  if (listaMjesta.isNotEmpty) {
                                    await dodajNovaMjesta();
                                  }
                                  await azurirajPostojecaMjesta(
                                      snapshot.data![1]);
                                  if (nazivSaleController.text !=
                                          widget.argumenti.individualnaSalaData
                                              .naziv ||
                                      listaMjesta.isNotEmpty) {
                                    await azurirajIndividualnuSalu(
                                        snapshot.data![1].length +
                                            listaMjesta.length);
                                  }

                                  Navigator.of(context).pop();
                                } on DioError catch (err) {
                                  print(err.message);
                                } catch (err) {
                                  print(err);
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

  void onDragEnd(Offset offset, int index) {
    setState(() {
      listaMjesta[index].pozicija.x += offset.dx;
      listaMjesta[index].pozicija.y += offset.dy;
    });
  }

  void dodajMjesto() {
    setState(() {
      listaMjesta.add(Mjesto(
          uticnica: true,
          dostupno: true,
          pozicija: PozicijaXY(x: 10.0, y: 50.0),
          velicina: double.parse(velicinaController.text),
          ugao: int.parse(ugaoController.text),
          qrCode: qrCodeController.text,
          brojMjesta: int.parse(brojController.text)));
    });
  }

  Future<Uint8List> dohvatiSliku() async {
    http.Response odgovor = await http.get(Uri.parse(
        'https://localhost:8443/api/v1/individualne-sale/${widget.argumenti.individualnaSalaData.id}/slika/'));
    if (odgovor.statusCode == 200) {
      return odgovor.bodyBytes;
    } else {
      return Uint8List(0);
    }
  }

  bool ispravneInformacijeMjesta() {
    if (velicinaController.text.isEmpty ||
        ugaoController.text.isEmpty ||
        qrCodeController.text.isEmpty ||
        brojController.text.isEmpty) {
      return false;
    } else {
      for (var item in listaMjesta) {
        if (item.brojMjesta == int.parse(brojController.text) ||
            item.qrCode == qrCodeController.text.toString()) {
          return false;
        }
      }
      return true;
    }
  }

  double getKoeficijentVelicineMjesta() {
    RenderBox? renderBoxNavRail =
        navigationRailKey.currentContext!.findRenderObject() as RenderBox?;
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
    RenderBox? renderBoxNavRail =
        navigationRailKey.currentContext!.findRenderObject() as RenderBox?;

    if (renderBoxNavRail != null) {
      return MediaQuery.of(context).size.width - renderBoxNavRail.size.width;
    } else {
      print('dddd');
      return 0;
    }
  }

  double getVisinaSlike() {
    RenderBox? renderBoxNavRail =
        navigationRailKey.currentContext!.findRenderObject() as RenderBox?;

    if (renderBoxNavRail != null) {
      return (MediaQuery.of(context).size.width - renderBoxNavRail.size.width) *
          0.5625;
    } else {
      print('dddd');
      return 0;
    }
  }

  // Future<bool> kreirajIndividualnuSalu(List<Mjesto>? postojecaMjesta) async {
  //   if (listaMjesta.isNotEmpty || postojecaMjesta != null) {
  //     if (postojecaMjesta!.isNotEmpty) {
  //       var futuresPostojecaMjesta = <Future>[];
  //       for (var item in postojecaMjesta) {
  //         futuresPostojecaMjesta.add(mjestaService.azurirajMjesta(
  //             dioClient: dioCL,
  //             individualnaSalaId: widget.individualnaSalaId.toString(),
  //             mjestoId: item.id.toString(),
  //             mjestoInfo: Mjesto(
  //                 brojMjesta: item.brojMjesta,
  //                 statusId: item.statusId,
  //                 ugao: item.ugao,
  //                 velicina: item.velicina,
  //                 pozicija: item.pozicija,
  //                 uticnica: item.uticnica,
  //                 qrCode: item.qrCode)));
  //       }
  //       await Future.wait(futuresPostojecaMjesta);
  //     }
  //     var futures = <Future>[];
  //     for (var item in listaMjesta) {
  //       futures.add(mjestaService.createMjesta(
  //           dioClient: dioCL,
  //           individualnaSalaId: widget.individualnaSalaId.toString(),
  //           mjestoInfo: item));
  //     }
  //     await Future.wait(futures);

  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<IndividualnaSala?> azurirajIndividualnuSalu(
      int azuriranBrojMjesta) async {
    IndividualnaSala? odgovor =
        await individualneSaleService.azurirajIndividualnuSalu(
            dioClient: dioCL,
            individualnaSalaData: IndividualnaSala(
              naziv: nazivSaleController.text.toString(),
              clanarine: widget.argumenti.individualnaSalaData.clanarine,
              karakteristike:
                  widget.argumenti.individualnaSalaData.karakteristike,
              opis: widget.argumenti.individualnaSalaData.opis,
              brojMjesta: azuriranBrojMjesta,
            ),
            citaonicaId: widget.argumenti.citaonicaId.toString(),
            individualnaSalaId:
                widget.argumenti.individualnaSalaData.id.toString());
    return odgovor;
  }

  Future<void> azurirajPostojecaMjesta(
      List<Mjesto> listaMjestaZaAzuriranje) async {
    var futurePostojecaMjesta = <Future>[];

    for (var item in listaMjestaZaAzuriranje) {
      futurePostojecaMjesta.add(mjestaService.azurirajMjesta(
          dioClient: dioCL,
          mjestoInfo: Mjesto(
              brojMjesta: item.brojMjesta,
              velicina: item.velicina,
              pozicija: item.pozicija,
              uticnica: item.uticnica,
              ugao: item.ugao,
              qrCode: item.qrCode,
              dostupno: item.dostupno),
          individualnaSalaId:
              widget.argumenti.individualnaSalaData.id.toString(),
          mjestoId: item.id.toString()));
    }
    Future.wait(futurePostojecaMjesta);
  }

  Future<void> dodajNovaMjesta() async {
    var futureNovaMjesta = <Future>[];
    for (var item in listaMjesta) {
      double povrsinaMjesta = item.velicina * item.velicina * 100;
      double povrsinaSale = getKoeficijentVelicineMjesta();
      double procenat = (povrsinaMjesta / povrsinaSale);
      futureNovaMjesta.add(mjestaService.createMjesta(
          dioClient: dioCL,
          individualnaSalaId:
              widget.argumenti.individualnaSalaData.id.toString(),
          mjestoInfo: Mjesto(
              brojMjesta: item.brojMjesta,
              ugao: item.ugao,
              uticnica: item.uticnica,
              qrCode: item.qrCode,
              velicina: procenat,
              pozicija: PozicijaXY(
                  x: item.pozicija.x / getSirinaSlike(),
                  y: item.pozicija.y / getVisinaSlike()),
              dostupno: item.dostupno)));
    }
    await Future.wait(futureNovaMjesta);
  }

  bool spremnoZaSlanje(List<Mjesto> postojecaMjestaSale) {
    if (nazivSaleController.text.isEmpty) {
      return false;
    } else {
      for (var item in listaMjesta) {
        if (postojecaMjestaSale.any((element) =>
            (element.brojMjesta == item.brojMjesta ||
                element.qrCode == item.qrCode))) {
          return false;
        } else {
          return true;
        }
      }
    }
    return true;
  }
}
