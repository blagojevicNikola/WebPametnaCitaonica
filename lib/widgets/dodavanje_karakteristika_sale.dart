import 'package:flutter/material.dart';
import 'package:web_aplikacija/models/karakteristike.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';
import 'package:web_aplikacija/widgets/information_field.dart';

import 'karakteristike_field.dart';

class DodavanjeKarakteristikaSale extends StatefulWidget {
  DodavanjeKarakteristikaSale(
      {Key? key,
      required this.listaPostojecihKarakteristika,
      required this.listaDodatihPostojecihKarakteristika,
      required this.listaDodatihKreiranihKarakteristika})
      : super(key: key);
  final List<Karakteristike> listaPostojecihKarakteristika;
  final List<KarakteristikeSale> listaDodatihPostojecihKarakteristika;
  final List<KarakteristikeSale> listaDodatihKreiranihKarakteristika;

  @override
  State<StatefulWidget> createState() {
    return _DodavanjeKarakteristikaSaleState();
  }
}

class _DodavanjeKarakteristikaSaleState
    extends State<DodavanjeKarakteristikaSale> {
  @override
  void initState() {
    listaDodatihKreiranihKarakteristika =
        widget.listaDodatihKreiranihKarakteristika;
    listaDodatihPostojecihKarakteristika =
        widget.listaDodatihPostojecihKarakteristika;
    super.initState();
  }

  late List<KarakteristikeSale> listaDodatihPostojecihKarakteristika;

  late List<KarakteristikeSale> listaDodatihKreiranihKarakteristika;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: SizedBox(
              width: 400,
              child: Wrap(
                spacing: 3.0,
                runSpacing: 3.0,
                direction: Axis.horizontal,
                children: [
                  for (var item in widget.listaPostojecihKarakteristika)
                    KarakteristikeField(naziv: item.naziv!, funkcija: dodaj),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Material(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              color: Colors.transparent,
              child: IconButton(
                  color: const Color.fromARGB(255, 105, 105, 105),
                  iconSize: 27,
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () async {
                    var novaKarakteristika = await dodajKarakteristikuDialog();
                    if (novaKarakteristika == null) {
                    } else {
                      if (!widget.listaPostojecihKarakteristika.any((element) =>
                              element.naziv == novaKarakteristika) &&
                          !vecKreiran(novaKarakteristika)) {
                        kreirajKarakteristiku(novaKarakteristika);
                      } else {
                        const snackBar = SnackBar(
                          backgroundColor: Color.fromARGB(255, 185, 44, 34),
                          content: Text(
                            'Karakteristika vec postoji!',
                            textAlign: TextAlign.center,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  }),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                //height: 150,
                padding: const EdgeInsets.all(9.0),
                //width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Wrap(
                  spacing: 3.0,
                  runSpacing: 3.0,
                  children: [
                    for (var item in listaDodatihPostojecihKarakteristika)
                      KarakteristikeField(
                          naziv: item.naziv!, funkcija: izbaciPostojeci),
                    for (var item in listaDodatihKreiranihKarakteristika)
                      KarakteristikeField(
                          funkcija: izbaciKreirani, naziv: item.naziv!)
                  ],
                )),
          ),
        ),
      ],
    );
  }

  void dodaj(String nazivTemp) {
    var result = listaDodatihPostojecihKarakteristika
        .any((element) => sadrzi(element.naziv!, nazivTemp));
    if (!result) {
      int index = (widget.listaPostojecihKarakteristika.indexWhere(
        (element) => element.naziv == nazivTemp,
      ));
      setState(() {
        listaDodatihPostojecihKarakteristika.add(KarakteristikeSale(
            karakteristikaId: widget.listaPostojecihKarakteristika[index].id,
            naziv: widget.listaPostojecihKarakteristika[index].naziv));
      });
    }
  }

  void izbaciPostojeci(String nazivTemp) {
    if (listaDodatihPostojecihKarakteristika.isNotEmpty) {
      int index = listaDodatihPostojecihKarakteristika
          .indexWhere((element) => element.naziv == nazivTemp);
      setState(() {
        listaDodatihPostojecihKarakteristika.removeAt(index);
      });
    }
  }

  void izbaciKreirani(String nazivTemp) {
    if (listaDodatihKreiranihKarakteristika.isNotEmpty) {
      int index = listaDodatihKreiranihKarakteristika
          .indexWhere((element) => element.naziv == nazivTemp);
      setState(() {
        listaDodatihKreiranihKarakteristika.removeAt(index);
      });
    }
  }

  bool sadrzi(String karakteristika, String nazivTemp) {
    if (karakteristika == nazivTemp) {
      return true;
    } else {
      return false;
    }
  }

  bool vecKreiran(String nazivTemp) {
    if (listaDodatihKreiranihKarakteristika.any(
      (element) => element.naziv == nazivTemp,
    )) {
      return true;
    } else {
      return false;
    }
  }

  void kreirajKarakteristiku(String nazivKarakteristike) {
    setState(() {
      listaDodatihKreiranihKarakteristika
          .add(KarakteristikeSale(naziv: nazivKarakteristike, detalji: ''));
    });
  }

  Future<String?> dodajKarakteristikuDialog() async {
    var nazivController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Dodaj karakteristiku'),
            content: Padding(
              padding: const EdgeInsets.all(9.0),
              child: SizedBox(
                width: 300,
                child: InformationField(
                    labelInformation: 'Naziv', control: nazivController),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Izadji'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Dodaj'),
                onPressed: () {
                  Navigator.pop(context, nazivController.text);
                },
              ),
            ],
          );
        });
  }
}
