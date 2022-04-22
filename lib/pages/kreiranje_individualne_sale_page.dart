import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_aplikacija/api/individualne_sale_service.dart';
import 'package:web_aplikacija/api/mjesta_service.dart';
import 'package:web_aplikacija/models/clanarina.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';
import 'package:web_aplikacija/models/pozicijaXY.dart';
import 'package:web_aplikacija/widgets/mjesto_widget.dart';

import '../api/dio_client.dart';
import '../models/individualna_sala.dart';
import '../models/mjesto.dart';

class KreiranjeIndivividualneSalePage extends StatefulWidget {
  int citaonicaId;
  KreiranjeIndivividualneSalePage({Key? key, required this.citaonicaId})
      : super(key: key);

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
  int? kreiranaIndividualnaSalaId;
  IndividualneSaleService indSaleService = IndividualneSaleService();
  MjestaService mjestaService = MjestaService();
  DioClient dioCL = DioClient();
  GlobalKey keySlike = GlobalKey();

  @override
  void dispose() {
    ugaoController.dispose();
    velicinaController.dispose();
    qrCodeController.dispose();
    brojController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                child: const Text('Nazad'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Row(
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
                        print(getKoeficijentVelicineMjesta());
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
            ],
          ),
          Stack(
            children: [
              (slika == null)
                  ? Container()
                  : Align(
                      alignment: Alignment.center,
                      child: Image.memory(
                        slika!,
                        key: keySlike,
                      )),
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
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                    onPressed: () async {
                      final kreirano = await kreirajIndividualnuSalu();
                      if (kreirano == true) {
                        Navigator.of(context).pop();
                      } else {
                        const snackBar = SnackBar(
                          backgroundColor: Color.fromARGB(255, 185, 44, 34),
                          content: Text(
                            'Greska pri kreiranju sale i dodavanju mjesta!',
                            textAlign: TextAlign.center,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ))
            ],
          ),
        ],
      ),
    );
  }

  void onDragEnd(Offset offset, int index) {
    setState(() {
      listaMjesta[index].pozicija.x += offset.dx;
      listaMjesta[index].pozicija.y += offset.dy;
    });
  }

  Future<bool> kreirajIndividualnuSalu() async {
    if (listaMjesta.isNotEmpty) {
      final salaTemp = await indSaleService.createIndividualnaSala(
        dioClient: dioCL,
        citaonicaId: widget.citaonicaId.toString(),
        sala: IndividualnaSala(
            naziv: nazivSaleController.text.toString(),
            clanarine: <Clanarina>[],
            karakteristike: <KarakteristikeSale>[],
            opis: "",
            brojMjesta: listaMjesta.length),
      );
      if (salaTemp != null) {
        kreiranaIndividualnaSalaId = salaTemp.id;
        var futures = <Future>[];
        for (var item in listaMjesta) {
          double povrsinaMjesta = item.velicina * item.velicina * 100;
          double povrsinaSale = getKoeficijentVelicineMjesta();
          double procenat = (povrsinaMjesta / povrsinaSale);
          futures.add(mjestaService.createMjesta(
              dioClient: dioCL,
              individualnaSalaId: kreiranaIndividualnaSalaId.toString(),
              mjestoInfo: Mjesto(
                  brojMjesta: item.brojMjesta,
                  pozicija: PozicijaXY(
                      x: item.pozicija.x / getSirinaSlike(),
                      y: item.pozicija.y / getVisinaSlike()),
                  ugao: item.ugao,
                  qrCode: item.qrCode,
                  statusId: item.statusId,
                  uticnica: item.uticnica,
                  velicina: procenat)));
        }
        await Future.wait(futures);
        FormData f = FormData.fromMap({
          'slika': MultipartFile.fromBytes(slika!.toList(),
              contentType: MediaType('image', 'png'), filename: 'index')
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        Dio dioSlika = Dio();
        dioSlika.options.headers['Authorization'] =
            'Bearer ${prefs.getString('accessToken')}';
        await dioSlika.post(
          'http://pametna-citaonica.azurewebsites.net/api/v1/individualne-sale/$kreiranaIndividualnaSalaId/slika',
          data: f,
        );
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
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

  double getKoeficijentVelicineMjesta() {
    RenderBox? renderBoxSlika =
        keySlike.currentContext!.findRenderObject() as RenderBox?;
    return renderBoxSlika!.size.height * renderBoxSlika.size.width;
  }

  double getVisinaSlike() {
    RenderBox? renderBoxSlika =
        keySlike.currentContext!.findRenderObject() as RenderBox?;
    print(renderBoxSlika!.size.height);
    return renderBoxSlika.size.height;
  }

  double getSirinaSlike() {
    RenderBox? renderBoxSlika =
        keySlike.currentContext!.findRenderObject() as RenderBox?;
    print(renderBoxSlika!.size.width);
    return renderBoxSlika.size.width;
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
    // int a = int.parse(velicinaController.text.toString());
    // int povrsinaMjesta = a * a * 100;
    // int povrsinaSale = getKoeficijentVelicineMjesta().round();
    // int procenat = (povrsinaMjesta / povrsinaSale).round();
    setState(() {
      listaMjesta.add(Mjesto(
          uticnica: true,
          statusId: 1,
          pozicija: PozicijaXY(x: 10.0, y: 50.0),
          velicina: double.parse(velicinaController.text),
          ugao: int.parse(ugaoController.text),
          qrCode: qrCodeController.text,
          brojMjesta: int.parse(brojController.text)));
    });
  }
}
