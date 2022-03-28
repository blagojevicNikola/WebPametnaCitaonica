import 'package:flutter/material.dart';

import '../../constants/config.dart';
import '../../models/dan.dart';
import '../../models/radno_vrijeme.dart';
import '../../widgets/information_field.dart';
import '../../widgets/unos_radnog_vremena.dart';

class PromjenaInformacijaCitaonice extends StatelessWidget {
  var nazivController = TextEditingController(text: '');
  var adresaController = TextEditingController(text: '');
  var telefonController = TextEditingController(text: '');
  var emailController = TextEditingController(text: '');

  Map<Dan, RadnoVrijemeUDanu?> radnoVr = {
    Dan.Ponedeljak: RadnoVrijemeUDanu(),
    Dan.Utorak: RadnoVrijemeUDanu(),
    Dan.Srijeda: RadnoVrijemeUDanu(),
    Dan.Cetrvrtak: RadnoVrijemeUDanu(),
    Dan.Petak: RadnoVrijemeUDanu(),
    Dan.Subota: RadnoVrijemeUDanu(),
    Dan.Nedelja: RadnoVrijemeUDanu()
  };
  PromjenaInformacijaCitaonice({Key? key}) : super(key: key);

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
                            onPressed: () {},
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
}
