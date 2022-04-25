import 'package:flutter/material.dart';
import 'package:web_aplikacija/models/karakteristike.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';

import 'karakteristike_field.dart';

class SupervizorskoDodavanjeKarakteristikaSale extends StatefulWidget {
  const SupervizorskoDodavanjeKarakteristikaSale({
    Key? key,
    required this.listaPostojecihKarakteristika,
    required this.listaDodatihPostojecihKarakteristika,
  }) : super(key: key);
  final List<Karakteristike> listaPostojecihKarakteristika;
  final List<KarakteristikeSale> listaDodatihPostojecihKarakteristika;

  @override
  State<StatefulWidget> createState() {
    return _SupervizorskoDodavanjeKarakteristikaSaleState();
  }
}

class _SupervizorskoDodavanjeKarakteristikaSaleState
    extends State<SupervizorskoDodavanjeKarakteristikaSale> {
  @override
  void initState() {
    listaDodatihPostojecihKarakteristika =
        widget.listaDodatihPostojecihKarakteristika;
    super.initState();
  }

  late List<KarakteristikeSale> listaDodatihPostojecihKarakteristika;

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

  bool sadrzi(String karakteristika, String nazivTemp) {
    if (karakteristika == nazivTemp) {
      return true;
    } else {
      return false;
    }
  }
}
