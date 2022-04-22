import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/grupne_sale_service.dart';
import 'package:web_aplikacija/api/karakteristike_sale_service.dart';
import 'package:web_aplikacija/constants/config.dart';
import 'package:web_aplikacija/models/karakteristike.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';
import 'package:web_aplikacija/widgets/dodavanje_karakteristika_sale.dart';

import '../api/dio_client.dart';
import '../models/clanarina.dart';
import '../models/grupna_sala.dart';
import '../widgets/information_field.dart';

class KreiranjeGrupneSalePage extends StatefulWidget {
  final int citaonicaId;

  const KreiranjeGrupneSalePage({required this.citaonicaId, Key? key})
      : super(key: key);

  @override
  State<KreiranjeGrupneSalePage> createState() =>
      _KreiranjeGrupneSalePageState();
}

class _KreiranjeGrupneSalePageState extends State<KreiranjeGrupneSalePage> {
  final nazivController = TextEditingController(text: '');

  final kapacitetController = TextEditingController(text: '');

  final opisController = TextEditingController(text: '');

  final kodController = TextEditingController(text: '');

  GrupneSaleService grupSale = GrupneSaleService();
  KarakteristikeSaleService karakteristikeSaleService =
      KarakteristikeSaleService();
  DioClient dioCL = DioClient();

  late Future<List<Karakteristike>> listaPostojecihKarakteristika;
  //  <KarakteristikeSale>[
  //   KarakteristikeSale(naziv: 'tv', karakteristikaId: 1),
  //   KarakteristikeSale(naziv: 'projektor', karakteristikaId: 3),
  //   KarakteristikeSale(naziv: 'wifi', karakteristikaId: 2),
  //   KarakteristikeSale(naziv: 'struja', karakteristikaId: 4),
  //   KarakteristikeSale(naziv: 'voda', karakteristikaId: 5),
  // ];

  List<KarakteristikeSale> listaDodatihPostojecih = <KarakteristikeSale>[];
  List<KarakteristikeSale> listaDodatihKreiranih = <KarakteristikeSale>[];

  @override
  void initState() {
    super.initState();
    listaPostojecihKarakteristika =
        karakteristikeSaleService.getKarakteristike(dioCL);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 32.5),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                      splashRadius: 25.0,
                      padding: const EdgeInsets.all(0),
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.keyboard_arrow_left)),
                ),
              ),
            ),
            const Divider(
              height: 65,
              color: Color.fromARGB(255, 177, 211, 240),
              thickness: 2,
              indent: 18,
              endIndent: 18,
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 242, 245),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.64,
                  child: Column(
                    children: [
                      SizedBox(
                        width:
                            (MediaQuery.of(context).size.width * 0.64) * 0.78,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'Ime',
                                control: nazivController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'Kapacitet',
                                control: kapacitetController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'Kod',
                                control: kodController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'Opis',
                                control: opisController,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(9),
                                child: Text("Karakteristike sale:",
                                    style: TextStyle(
                                        fontSize: 40, color: defaultPlava)),
                              ),
                            ),
                            FutureBuilder<List<Karakteristike>>(
                                future: listaPostojecihKarakteristika,
                                initialData: null,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox(
                                        height: 120,
                                        width: 120,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(9.0),
                                        child: DodavanjeKarakteristikaSale(
                                          listaPostojecihKarakteristika:
                                              snapshot.data!,
                                          listaDodatihKreiranihKarakteristika:
                                              listaDodatihKreiranih,
                                          listaDodatihPostojecihKarakteristika:
                                              listaDodatihPostojecih,
                                        ),
                                      );
                                    } else {
                                      return const Text('Empty data');
                                    }
                                  } else {
                                    return Text(
                                        'State: ${snapshot.connectionState}');
                                  }
                                }),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
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
                              //print('Citaonica $citaonicaId');
                              if (ispravnostInformacijaSale()) {
                                //await dodajNoveKarakteristike();
                                List<Karakteristike> tempKreirane =
                                    <Karakteristike>[];
                                if (listaDodatihKreiranih.isNotEmpty) {
                                  tempKreirane =
                                      await dodajNoveKarakteristike();
                                }
                                List<KarakteristikeSale> temp =
                                    <KarakteristikeSale>[];
                                for (var item in listaDodatihPostojecih) {
                                  temp.add(KarakteristikeSale(
                                    karakteristikaId: item.karakteristikaId,
                                  ));
                                }
                                for (var item in tempKreirane) {
                                  temp.add(KarakteristikeSale(
                                      karakteristikaId: item.id));
                                }
                                Response? res = await grupSale.createGrupnaSala(
                                    dioClient: dioCL,
                                    citaonicaId: widget.citaonicaId.toString(),
                                    sala: GrupnaSala(
                                        naziv: nazivController.text.toString(),
                                        brojMjesta: int.parse(
                                            kapacitetController.text
                                                .toString()),
                                        qrKod: kodController.text.toString(),
                                        opis: opisController.text.toString(),
                                        clanarine: <Clanarina>[],
                                        karakteristike: temp,
                                        statusId: 1));
                                if (res != null) {
                                  if (res.statusCode == 201) {
                                    Navigator.of(context).pop();
                                  }
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool ispravnostInformacijaSale() {
    if (nazivController.text.isEmpty ||
        kodController.text.isEmpty ||
        kapacitetController.text.isEmpty ||
        opisController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<Karakteristike>> dodajNoveKarakteristike() async {
    var futures = <Future<Karakteristike>>[];
    for (var item in listaDodatihKreiranih) {
      futures.add(karakteristikeSaleService.createKarakteristika(
          dioClient: dioCL,
          karakteristikaInfo: Karakteristike(naziv: item.naziv)));
    }
    List<Karakteristike> noveKarak = await Future.wait(futures);
    //ovdje mozda mogu sacuvati listu kreiranih karakteristika te ih ponovo poslati zajedno sa vec postojecim karakteristika
    return noveKarak;
  }

  GrupnaSala kreiranjeSale() {
    return GrupnaSala(
        naziv: nazivController.text.toString(),
        brojMjesta: int.parse(kapacitetController.text.toString()),
        qrKod: kodController.text.toString(),
        opis: opisController.text.toString(),
        clanarine: <Clanarina>[],
        karakteristike: <KarakteristikeSale>[],
        statusId: 1);
  }
}
