import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/citaonica_service.dart';
import 'package:web_aplikacija/constants/config.dart';
import 'package:web_aplikacija/widgets/unos_radnog_vremena.dart';

import '../models/citaonica.dart';

import '../models/radno_vrijeme.dart';
import '../widgets/information_field.dart';

class DodavanjeCitaonicaPage extends StatefulWidget {
  const DodavanjeCitaonicaPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DodavanjeCitaonicaPageState();
  }
}

class _DodavanjeCitaonicaPageState extends State<DodavanjeCitaonicaPage> {
  Uint8List? slika;
  final nazivController = TextEditingController(text: '');
  final adresaController = TextEditingController(text: '');
  final telefonController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');

  List<RadnoVrijemeUDanu> radnoVr = <RadnoVrijemeUDanu>[
    RadnoVrijemeUDanu(id: 1),
    RadnoVrijemeUDanu(id: 2),
    RadnoVrijemeUDanu(id: 3),
    RadnoVrijemeUDanu(id: 4),
    RadnoVrijemeUDanu(id: 5),
    RadnoVrijemeUDanu(id: 6),
    RadnoVrijemeUDanu(id: 7),
  ];

  CitaonicaService citService = CitaonicaService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                const Divider(
                  height: 80,
                  color: Color.fromARGB(255, 177, 211, 240),
                  thickness: 2,
                  indent: 18,
                  endIndent: 18,
                ),
                const SizedBox(height: 32.5),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 242, 245),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.64,
                  //height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        width:
                            (MediaQuery.of(context).size.width * 0.64) * 0.78,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                  labelInformation: 'Naziv',
                                  control: nazivController),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'Adresa',
                                control: adresaController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'E-mail',
                                control: emailController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'Broj telefona',
                                control: telefonController,
                              ),
                            ),
                            const SizedBox(height: 45),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(9),
                                child: Text(
                                  'Radno Vrijeme:',
                                  style: TextStyle(
                                      fontSize: 40, color: defaultPlava),
                                ),
                              ),
                            ),
                            UnosRadnogVremena(radnoVr: radnoVr),
                            const SizedBox(height: 45),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(9),
                                child: Text(
                                  'Slika čitaonice:',
                                  style: TextStyle(
                                      fontSize: 40, color: defaultPlava),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              child: ((slika == null)
                                  ? const SizedBox(
                                      height: 40,
                                      width: 80,
                                      child: Text('No image'))
                                  : Image.memory(slika!)),
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    child: const Text('Ucitaj sliku'),
                                    onPressed: () => pickImage(),
                                  ),
                                  TextButton(
                                    child: const Text('Ukloni sliku'),
                                    onPressed: () => removeImage(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
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
                            onPressed: () {
                              if (ispravnostInformacijaCitaonice()) {
                                kreirajCitaonicu();
                              } else {
                                const snackBar = SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 185, 44, 34),
                                  content: Text(
                                    'Neispravne informacije citaonice!',
                                    textAlign: TextAlign.center,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool ispravnostInformacijaCitaonice() {
    if (slika == null ||
        nazivController.text.isEmpty ||
        adresaController.text.isEmpty ||
        telefonController.text.isEmpty ||
        emailController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void kreirajCitaonicu() {
    citService.createCitaonica(
      citaonicaInfo: Citaonica(
        vlasnik: 'nesto',
        name: nazivController.text.toString(),
        mail: emailController.text.toString(),
        phoneNumber: telefonController.text.toString(),
        adresa: adresaController.text.toString(),
        radnoVrijeme: radnoVr,
      ),
    );
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
}
