import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../api/mjesta_service.dart';
import '../models/mjesto.dart';
import '../models/pozicijaXY.dart';
import '../widgets/postojece_mjesto_widget.dart';
import 'package:web_aplikacija/widgets/mjesto_widget.dart';

class IzmjenaIndividualneSalePage extends StatefulWidget {
  //final List<Mjesto> listaPostojecihMjesta;
  int individualnaSalaId;
  IzmjenaIndividualneSalePage({Key? key, required this.individualnaSalaId})
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
  List<Mjesto> listaMjesta = <Mjesto>[];
  final ugaoController = TextEditingController();
  final velicinaController = TextEditingController();
  final qrCodeController = TextEditingController();
  final brojController = TextEditingController();
  final nazivSaleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FutureBuilder<List<Mjesto>>(
            future:
                mjestaService.getMjesta(widget.individualnaSalaId.toString()),
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
                            TextButton(
                              child: const Text('Dodaj sliku'),
                              onPressed: () => pickImage(),
                            ),
                            TextButton(
                              child: const Text('Ukloni sliku'),
                              onPressed: () => removeImage(),
                            ),
                            TextButton(
                                child: const Text('Dodaj mjesto'),
                                onPressed: () {
                                  if (!ispravneInformacijeMjesta()) {
                                    const snackBar = SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 185, 44, 34),
                                      content: Text(
                                        'Pogresne informacije mjesta!',
                                        textAlign: TextAlign.center,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
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
                                    style: const TextStyle(
                                        fontSize: 19, height: 1.1),
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
                                    style: const TextStyle(
                                        fontSize: 19, height: 1.1),
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
                                    style: const TextStyle(
                                        fontSize: 19, height: 1.1),
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
                                    style: const TextStyle(
                                        fontSize: 19, height: 1.1),
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
                          child: PostojeceMjestoWidget(
                            index: item.brojMjesta,
                            velicina: item.velicina,
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
                              final odgovor =
                                  await kreirajIndividualnuSalu(snapshot.data);
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
          statusId: 1,
          pozicija: PozicijaXY(x: 10.0, y: 50.0),
          velicina: int.parse(velicinaController.text),
          ugao: int.parse(ugaoController.text),
          qrCode: qrCodeController.text,
          brojMjesta: int.parse(brojController.text)));
    });
  }

  void pickImage() async {
    var picked = await FilePicker.platform.pickFiles();
    if (picked != null) {
      setState(() {
        slika = picked.files.first.bytes;
      });
    }
  }

  void removeImage() async {
    if (slika != null) {
      setState(
        () {
          slika = null;
        },
      );
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

  Future<bool> kreirajIndividualnuSalu(List<Mjesto>? postojecaMjesta) async {
    if (listaMjesta.isNotEmpty || postojecaMjesta != null) {
      if (postojecaMjesta!.isNotEmpty) {
        var futuresPostojecaMjesta = <Future>[];
        for (var item in postojecaMjesta) {
          futuresPostojecaMjesta.add(mjestaService.azurirajMjesta(
              individualnaSalaId: widget.individualnaSalaId.toString(),
              mjestoId: item.id.toString(),
              mjestoInfo: Mjesto(
                  brojMjesta: item.brojMjesta,
                  statusId: item.statusId,
                  ugao: item.ugao,
                  velicina: item.velicina,
                  pozicija: item.pozicija,
                  uticnica: item.uticnica,
                  qrCode: item.qrCode)));
        }
        await Future.wait(futuresPostojecaMjesta);
      }
      var futures = <Future>[];
      for (var item in listaMjesta) {
        futures.add(mjestaService.createMjesta(
            individualnaSalaId: widget.individualnaSalaId.toString(),
            mjestoInfo: item));
      }
      await Future.wait(futures);

      return true;
    } else {
      return false;
    }
  }
}
