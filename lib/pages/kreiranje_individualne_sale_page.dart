import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_aplikacija/widgets/mjesto_widget.dart';

import '../models/mjesto.dart';

class KreiranjeIndivividualneSalePage extends StatefulWidget {
  const KreiranjeIndivividualneSalePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KreiranjeIdividualneSalePageState();
  }
}

class _KreiranjeIdividualneSalePageState
    extends State<KreiranjeIndivividualneSalePage> {
  Uint8List? slika;
  List<Mjesto> listaMjesta = <Mjesto>[];
  final ugaoController = TextEditingController();
  final velicinaController = TextEditingController();
  final qrCodeController = TextEditingController();
  final brojController = TextEditingController();
  final nazivSaleController = TextEditingController();

  @override
  void dispose() {
    ugaoController.dispose();
    velicinaController.dispose();
    qrCodeController.dispose();
    brojController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
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
                  },
                ),
                const SizedBox(width: 30),
                Row(
                  children: [
                    const Text('Velicina: '),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        style: const TextStyle(fontSize: 19, height: 1.1),
                        controller: velicinaController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                        style: const TextStyle(fontSize: 19, height: 1.1),
                        controller: ugaoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                        style: const TextStyle(fontSize: 19, height: 1.1),
                        controller: qrCodeController,
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
                        style: const TextStyle(fontSize: 19, height: 1.1),
                        controller: brojController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                        style: const TextStyle(fontSize: 19, height: 1.1),
                        controller: nazivSaleController,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          for (var item in listaMjesta)
            Positioned(
              left: item.pozicija.dx,
              top: item.pozicija.dy,
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
                  style: TextStyle(fontSize: 21, color: Colors.white),
                ),
                onPressed: () {},
              ))
        ],
      ),
    );
  }

  void onDragEnd(Offset offset, int index) {
    setState(() {
      listaMjesta[index].pozicija += offset;
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

  void dodajMjesto() {
    setState(() {
      listaMjesta.add(Mjesto(
          pozicija: Offset(10, 50),
          velicina: double.parse(velicinaController.text),
          ugao: double.parse(ugaoController.text),
          qrCode: qrCodeController.text,
          brojMjesta: int.parse(brojController.text)));
    });
  }
}
