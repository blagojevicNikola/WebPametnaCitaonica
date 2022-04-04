import 'package:flutter/material.dart';
import '../models/grupna_sala.dart';
import '../models/karakteristike_sale.dart';
import '../widgets/dodavanje_karakteristika_sale.dart';
import '../widgets/information_field.dart';

class IzmjenaGrupneSalePage extends StatefulWidget {
  GrupnaSala grupnaSalaData;

  IzmjenaGrupneSalePage({Key? key, required this.grupnaSalaData})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _IzmjenaGrupneSalePageState();
  }
}

class _IzmjenaGrupneSalePageState extends State<IzmjenaGrupneSalePage> {
  TextEditingController? nazivSaleController;
  TextEditingController? qrCodeSaleController;
  TextEditingController? brojMjestaSaleController;
  TextEditingController? opisSaleController;
  List<KarakteristikeSale> listaPostojecihKarakteristika = <KarakteristikeSale>[
    KarakteristikeSale(naziv: 'tv', karakteristikaId: 1),
    KarakteristikeSale(naziv: 'projektor', karakteristikaId: 3),
    KarakteristikeSale(naziv: 'wifi', karakteristikaId: 2),
    KarakteristikeSale(naziv: 'struja', karakteristikaId: 4),
    KarakteristikeSale(naziv: 'voda', karakteristikaId: 5),
  ];

  List<KarakteristikeSale> listaDodatihPostojecih = <KarakteristikeSale>[];
  List<KarakteristikeSale> listaDodatihKreiranih = <KarakteristikeSale>[];

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
                                      text: widget.grupnaSalaData.naziv),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: InformationField(
                              labelInformation: 'QR Code',
                              control: qrCodeSaleController =
                                  TextEditingController(
                                      text: widget.grupnaSalaData.qrKod),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: InformationField(
                              labelInformation: 'Broj mjesta',
                              control: brojMjestaSaleController =
                                  TextEditingController(
                                text:
                                    widget.grupnaSalaData.brojMjesta.toString(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: InformationField(
                              labelInformation: 'Opis',
                              control: opisSaleController =
                                  TextEditingController(
                                      text: widget.grupnaSalaData.opis),
                            ),
                          ),
                          DodavanjeKarakteristikaSale(
                            listaPostojecihKarakteristika:
                                listaPostojecihKarakteristika,
                            listaDodatihKreiranihKarakteristika:
                                listaDodatihKreiranih,
                            listaDodatihPostojecihKarakteristika:
                                listaDodatihPostojecih,
                          ),
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
                                onPressed: () async {},
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
}
