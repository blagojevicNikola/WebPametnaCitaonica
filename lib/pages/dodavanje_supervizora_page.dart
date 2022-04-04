import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/supervizor_service.dart';

import '../models/nalog.dart';
import '../widgets/information_field.dart';

class DodavanjeSupervizoraPage extends StatelessWidget {
  final int citaonicaId;
  var imeController = TextEditingController();
  var prezimeController = TextEditingController();
  var korisnickoController = TextEditingController();
  var emailController = TextEditingController();
  var lozinkaController = TextEditingController();
  SupervizorService supervizorService = SupervizorService();

  DodavanjeSupervizoraPage({Key? key, required this.citaonicaId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        color: Colors.white,
        child: Column(
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
            const SizedBox(height: 40),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 242, 245),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.64,
                  height: MediaQuery.of(context).size.height,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: InformationField(
                        labelInformation: 'Ime',
                        control: imeController =
                            TextEditingController(text: ''),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: InformationField(
                        labelInformation: 'Prezime',
                        control: prezimeController =
                            TextEditingController(text: ''),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: InformationField(
                        labelInformation: 'Korisnicko ime',
                        control: korisnickoController =
                            TextEditingController(text: ''),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: InformationField(
                        labelInformation: 'E-mail',
                        control: emailController =
                            TextEditingController(text: ''),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: InformationField(
                        labelInformation: 'Lozinka',
                        control: lozinkaController =
                            TextEditingController(text: ''),
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
                            style: TextStyle(fontSize: 21, color: Colors.white),
                          ),
                          onPressed: () async {
                            if (ispravneInformacijeSupervizora()) {
                              final response =
                                  await supervizorService.createSupervizor(
                                citaonicaId: citaonicaId.toString(),
                                supervizorInfo: Nalog(
                                  ime: imeController.text.toString(),
                                  prezime: prezimeController.text.toString(),
                                  korisnickoIme:
                                      korisnickoController.text.toString(),
                                  mail: emailController.text.toString(),
                                  lozinka: lozinkaController.text.toString(),
                                ),
                              );
                              if (response != null) {
                                Navigator.of(context).pop();
                              } else {
                                const snackBar = SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 185, 44, 34),
                                  content: Text(
                                    'Greska pri dodavanju supervizorskog naloga!',
                                    textAlign: TextAlign.center,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              const snackBar = SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 185, 44, 34),
                                content: Text(
                                  'Pogresno ispunjene informacije o korisniku!',
                                  textAlign: TextAlign.center,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                      ),
                    )
                  ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool ispravneInformacijeSupervizora() {
    if (imeController.text.isEmpty ||
        prezimeController.text.isEmpty ||
        korisnickoController.text.isEmpty ||
        emailController.text.isEmpty ||
        lozinkaController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
