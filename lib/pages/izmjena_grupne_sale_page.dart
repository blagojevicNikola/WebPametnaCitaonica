import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/grupne_sale_service.dart';
import 'package:web_aplikacija/api/karakteristike_sale_service.dart';
import 'package:web_aplikacija/models/argumenti_izmjene_grupne_sale.dart';
import 'package:web_aplikacija/models/karakteristike.dart';
import '../api/dio_client.dart';
import '../models/grupna_sala.dart';
import '../models/karakteristike_sale.dart';
import '../widgets/dodavanje_karakteristika_sale.dart';
import '../widgets/information_field.dart';

class IzmjenaGrupneSalePage extends StatefulWidget {
  final ArgumentiIzmjeneGrupneSale data;

  const IzmjenaGrupneSalePage({Key? key, required this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _IzmjenaGrupneSalePageState();
  }
}

class _IzmjenaGrupneSalePageState extends State<IzmjenaGrupneSalePage> {
  TextEditingController nazivSaleController = TextEditingController();
  TextEditingController qrCodeSaleController = TextEditingController();
  TextEditingController brojMjestaSaleController = TextEditingController();
  TextEditingController opisSaleController = TextEditingController();
  // List<Karakteristike> listaPostojecihKarakteristika = <Karakteristike>[
  //   Karakteristike(naziv: 'tv', id: 1),
  //   Karakteristike(naziv: 'projektor', id: 3),
  //   Karakteristike(naziv: 'wifi', id: 2),
  //   Karakteristike(naziv: 'struja', id: 4),
  //   Karakteristike(naziv: 'voda', id: 5),
  // ];

  late Future<List<Karakteristike>> listaPostojecihKarakteristika;

  List<KarakteristikeSale> listaDodatihPostojecih = <KarakteristikeSale>[];
  List<KarakteristikeSale> listaDodatihKreiranih = <KarakteristikeSale>[];
  KarakteristikeSaleService karakteristikeSaleService =
      KarakteristikeSaleService();
  GrupneSaleService grupneSaleService = GrupneSaleService();
  DioClient dioCL = DioClient();

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
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
                    const SizedBox(height: 40),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.64) * 0.78,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: InformationField(
                              labelInformation: 'Naziv sale',
                              control: nazivSaleController =
                                  TextEditingController(
                                      text: widget.data.grupnaSalaData.naziv),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: InformationField(
                              labelInformation: 'Broj mjesta',
                              control: brojMjestaSaleController =
                                  TextEditingController(
                                text: widget.data.grupnaSalaData.brojMjesta
                                    .toString(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: InformationField(
                              labelInformation: 'QR Code',
                              control: qrCodeSaleController =
                                  TextEditingController(
                                      text: widget.data.grupnaSalaData.qrKod),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: InformationField(
                              labelInformation: 'Opis',
                              control: opisSaleController =
                                  TextEditingController(
                                      text: widget.data.grupnaSalaData.opis),
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
                                          child: CircularProgressIndicator()));
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
                                              widget.data.grupnaSalaData
                                                  .karakteristike,
                                        ));
                                  } else {
                                    return const Text('Empty data');
                                  }
                                } else {
                                  return Text(
                                      'State: ${snapshot.connectionState}');
                                }
                              }),
                          const SizedBox(height: 30),
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
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 87, 182, 93),
                                    ),
                                    overlayColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 112, 218, 116))),
                                child: const Text(
                                  'Sacuvaj',
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (ispravnostInformacijaSale()) {
                                    Response? odgovor = await updateSala();
                                    if (odgovor != null) {
                                      if (odgovor.statusCode == 200) {
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
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  bool ispravnostInformacijaSale() {
    if (nazivSaleController.text.isEmpty ||
        qrCodeSaleController.text.isEmpty ||
        brojMjestaSaleController.text.isEmpty) {
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

  Future<Response?> updateSala() async {
    List<Karakteristike> noveKarakteristike = await dodajNoveKarakteristike();
    List<KarakteristikeSale> temp = <KarakteristikeSale>[];
    for (var item in noveKarakteristike) {
      temp.add(KarakteristikeSale(karakteristikaId: item.id));
    }
    Response? odgovor = await grupneSaleService.azurirajGrupnuSalu(
        dioClient: dioCL,
        grupnaSalaData: GrupnaSala(
            id: widget.data.grupnaSalaData.id,
            naziv: nazivSaleController.text.toString(),
            qrKod: qrCodeSaleController.text.toString(),
            brojMjesta: int.parse(brojMjestaSaleController.text.toString()),
            opis: opisSaleController.text.toString(),
            statusId: 1,
            clanarine: widget.data.grupnaSalaData.clanarine,
            karakteristike: widget.data.grupnaSalaData.karakteristike + temp),
        citaonicaId: widget.data.citaonicaId);
    return odgovor;
  }
}
