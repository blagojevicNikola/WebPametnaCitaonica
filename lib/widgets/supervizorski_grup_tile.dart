import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/api/grupne_sale_service.dart';
import 'package:web_aplikacija/models/argumenti_izmjene_grupne_sale.dart';

import '../constants/config.dart';
import '../models/grupna_sala.dart';

class SupervizorskaGrupTile extends StatefulWidget {
  // final String naziv;
  // final int brojMjesta;
  // final bool tv;
  // final bool projektor;
  // final bool klima;
  final String citaonicaId;
  final GrupnaSala grupnaSalaData;

  const SupervizorskaGrupTile({
    Key? key,
    // required this.naziv,
    // required this.brojMjesta,
    // required this.tv,
    // required this.projektor,
    // required this.klima,
    required this.citaonicaId,
    required this.grupnaSalaData,
  }) : super(key: key);

  @override
  State<SupervizorskaGrupTile> createState() => _SupervizorskaGrupTileState();
}

class _SupervizorskaGrupTileState extends State<SupervizorskaGrupTile> {
  GrupneSaleService grupneSaleService = GrupneSaleService();
  DioClient dioCL = DioClient();

  late bool dostupnaSala;

  @override
  void initState() {
    dostupnaSala = widget.grupnaSalaData.dostupno;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (dostupnaSala == true)
            ? Colors.white
            : const Color.fromARGB(255, 222, 222, 222),
        borderRadius: BorderRadius.circular(21),
      ),
      width: double.infinity,
      height: 60,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                child: Text(
                  widget.grupnaSalaData.naziv,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 105, 105, 105),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                    child: Text(
                      widget.grupnaSalaData.brojMjesta.toString(),
                      style: const TextStyle(
                          fontSize: 24, color: defaultKarakteristike),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 9, 0),
                    child: Icon(Icons.person,
                        size: 24, color: defaultKarakteristike),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        color: const Color.fromARGB(255, 105, 105, 105),
                        splashRadius: 25,
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).pushNamed('pregled_grupne_sale',
                              arguments: ArgumentiIzmjeneGrupneSale(
                                  citaonicaId: widget.citaonicaId,
                                  grupnaSalaData: widget.grupnaSalaData));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        hoverColor: (dostupnaSala == false)
                            ? const Color.fromARGB(255, 118, 198, 122)
                            : const Color.fromARGB(255, 224, 110, 102),
                        splashColor: (dostupnaSala == false)
                            ? const Color.fromARGB(255, 57, 218, 65)
                            : const Color.fromARGB(255, 235, 61, 48),
                        color: const Color.fromARGB(255, 105, 105, 105),
                        splashRadius: 25,
                        icon: const Icon(Icons.lock),
                        onPressed: () async {
                          await zakljucajGrupnuSalu(
                              widget.grupnaSalaData.id!, !dostupnaSala);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> zakljucajGrupnuSalu(int grupnaSalaId, bool dostupno) async {
    Response? temp = await grupneSaleService.zakljucajGrupnuSalu(
        dioClient: dioCL,
        dostupno: dostupno,
        citaonicaId: widget.citaonicaId,
        grupnaSalaId: grupnaSalaId.toString());
    if (temp != null) {
      if (temp.statusCode == 200) {
        widget.grupnaSalaData.dostupno = dostupno;
        setState(() {
          dostupnaSala = !dostupnaSala;
        });
      }
    }
  }
}
