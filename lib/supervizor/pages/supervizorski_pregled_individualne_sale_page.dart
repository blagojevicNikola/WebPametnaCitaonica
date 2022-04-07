import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/individualne_sale_service.dart';
import 'package:web_aplikacija/models/clanarina.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';
import 'package:web_aplikacija/models/mjesto.dart';
import 'package:web_aplikacija/widgets/supervizorsko_mjesto_widget.dart';

import '../../api/dio_client.dart';
import '../../api/mjesta_service.dart';
import 'package:web_aplikacija/widgets/mjesto_widget.dart';

import '../../models/individualna_sala.dart';

class IzmjenaIndividualneSalePage extends StatefulWidget {
  //final List<Mjesto> listaPostojecihMjesta;
  int citaonicaId;
  int individualnaSalaId;
  IzmjenaIndividualneSalePage({Key? key, required this.individualnaSalaId, required this.citaonicaId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IzmjenaIndividualneSalePageState();
  }
}

class _IzmjenaIndividualneSalePageState
    extends State<IzmjenaIndividualneSalePage> {
  Uint8List? slika;
  MjestaService mjestaService = MjestaService();
  late final Future<List<Mjesto>> listaPostojecihMjesta;
  final nazivSaleController = TextEditingController();
  IndividualneSaleService individualneSaleService = IndividualneSaleService();
  DioClient dioCL = DioClient();

  @override
  void initState() {
    super.initState();
    listaPostojecihMjesta =
        mjestaService.getMjesta(dioCL, widget.individualnaSalaId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FutureBuilder<List<Mjesto>>(
            future: listaPostojecihMjesta,
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                    height: 120,
                    width: 120,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Stack(
                    children: [
                      (slika == null) ? Container() : Image.memory(slika!),
                      Positioned(
                        top: 14,
                        child: Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              child: const Text('Nazad'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )),
                      ),
                      Positioned(
                        top: 14,
                        left: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                const Text('Naziv sale: '),
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: nazivSaleController,
                                    style: const TextStyle(
                                        fontSize: 19, height: 1.1),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      for (var item in snapshot.data!)
                        Positioned(
                          left: item.pozicija.x,
                          top: item.pozicija.y,
                          child: SupervizorskoMjestoWidget(
                            id: item.id!,
                            index: item.brojMjesta,
                            velicina: item.velicina,
                            ugao: item.ugao,
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
            }));
  }

  bool ispravneInformacijeSale() {
    if (nazivSaleController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> azurirajIndividualnuSalu() async {
    IndividualnaSala? odgovor =
        await individualneSaleService.azurirajIndividualnuSalu(
      dioClient: dioCL,
      individualnaSalaData: IndividualnaSala(
          id: widget.individualnaSalaId
          naziv: nazivSaleController.text.toString(),
          clanarine: <Clanarina>[],
          karakteristike: <KarakteristikeSale>[]),
      citaonicaId: widget.citaonicaId.toString(),
    );
    if (odgovor != null) {
      return true;
    } else {
      return false;
    }
  }
}
