import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/citaonica_service.dart';
import 'package:web_aplikacija/api/dio_client.dart';

import '../../constants/config.dart';
import '../../models/citaonica.dart';
import '../../models/radno_vrijeme.dart';
import '../../widgets/information_field.dart';
import '../../widgets/unos_radnog_vremena.dart';

class PromjenaInformacijaCitaonice extends StatefulWidget {
  final int citaonicaId;
  const PromjenaInformacijaCitaonice({Key? key, required this.citaonicaId})
      : super(key: key);

  @override
  State<PromjenaInformacijaCitaonice> createState() =>
      _PromjenaInformacijaCitaoniceState();
}

class _PromjenaInformacijaCitaoniceState
    extends State<PromjenaInformacijaCitaonice> {
  TextEditingController nazivController = TextEditingController();

  TextEditingController adresaController = TextEditingController();

  TextEditingController telefonController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController opisController = TextEditingController();
  TextEditingController vlasnikController = TextEditingController();

  List<RadnoVrijemeUDanu> radnoVr = <RadnoVrijemeUDanu>[
    RadnoVrijemeUDanu(id: 1),
    RadnoVrijemeUDanu(id: 2),
    RadnoVrijemeUDanu(id: 3),
    RadnoVrijemeUDanu(id: 4),
    RadnoVrijemeUDanu(id: 5),
    RadnoVrijemeUDanu(id: 6),
    RadnoVrijemeUDanu(id: 7),
  ];

  late Future<Citaonica> citaonica;
  CitaonicaService citaonicaService = CitaonicaService();
  DioClient dioCL = DioClient();
  @override
  void initState() {
    citaonica = citaonicaService.getJednaCitaonica(dioCL, '12');
    super.initState();
  }

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
                  child: FutureBuilder<Citaonica>(
                      future: citaonica,
                      initialData: null,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                              height: 120,
                              width: 120,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            for (int i = 0; i < radnoVr.length; i++) {
                              int pozicija = snapshot.data!.radnoVrijeme
                                  .indexWhere((element) => element.id == i + 1);
                              if (pozicija != -1) {
                                radnoVr[i].pocetak = snapshot
                                    .data!.radnoVrijeme[pozicija].pocetak;
                                radnoVr[i].kraj =
                                    snapshot.data!.radnoVrijeme[pozicija].kraj;
                              }
                            }
                            return Column(
                              children: [
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width *
                                          0.64) *
                                      0.78,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(9),
                                        child: InformationField(
                                            labelInformation: 'Naziv',
                                            control: nazivController =
                                                TextEditingController(
                                                    text: snapshot.data!.name)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(9),
                                        child: InformationField(
                                          labelInformation: 'Adresa',
                                          control: adresaController =
                                              TextEditingController(
                                                  text: snapshot.data!.adresa),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(9),
                                        child: InformationField(
                                          labelInformation: 'E-mail',
                                          control: emailController =
                                              TextEditingController(
                                                  text: snapshot.data!.mail),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(9),
                                        child: InformationField(
                                          labelInformation: 'Broj telefona',
                                          control: telefonController =
                                              TextEditingController(
                                                  text: snapshot
                                                      .data!.phoneNumber),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(9),
                                        child: InformationField(
                                            labelInformation: 'Vlasnik',
                                            control: vlasnikController =
                                                TextEditingController(
                                                    text: snapshot
                                                        .data!.vlasnik)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(9),
                                        child: InformationField(
                                          labelInformation: 'Opis',
                                          control: opisController =
                                              TextEditingController(
                                                  text: snapshot.data!.opis),
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
                                                fontSize: 40,
                                                color: defaultPlava),
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
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            const Color.fromARGB(
                                                255, 87, 182, 93),
                                          ),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 112, 218, 116))),
                                      child: const Text(
                                        'Sacuvaj',
                                        style: TextStyle(
                                            fontSize: 21, color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        if (ispravneInformacijeCitaonice()) {
                                          Response? odgovor =
                                              await azurirajCitaonicu();
                                          if (odgovor != null) {
                                            if (odgovor.statusCode == 200) {
                                              const snackBar = SnackBar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 40, 233, 40),
                                                content: Text(
                                                  'Uspjesna izmjena citaonice!',
                                                  textAlign: TextAlign.center,
                                                ),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              const snackBar = SnackBar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 185, 44, 34),
                                                content: Text(
                                                  'Neuspjesna izmjena citaonice!',
                                                  textAlign: TextAlign.center,
                                                ),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          } else {
                                            const snackBar = SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 185, 44, 34),
                                              content: Text(
                                                'Neuspjesna izmjena citaonice!',
                                                textAlign: TextAlign.center,
                                              ),
                                            );

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        } else {
                                          const snackBar = SnackBar(
                                            backgroundColor: Color.fromARGB(
                                                255, 185, 44, 34),
                                            content: Text(
                                              'Pogresno ispunjene informacije citaonice!',
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
                            );
                          } else {
                            return const Text('Empty data');
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool ispravneInformacijeCitaonice() {
    if (nazivController.text.isEmpty ||
        adresaController.text.isEmpty ||
        telefonController.text.isEmpty ||
        emailController.text.isEmpty ||
        vlasnikController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<Response?> azurirajCitaonicu() async {
    Response? odgovor = await citaonicaService.azurirajCitaonicu(
        dioClient: dioCL,
        citaonicaInfo: Citaonica(
          name: nazivController.text.toString(),
          mail: emailController.text.toString(),
          phoneNumber: telefonController.text.toString(),
          adresa: adresaController.text.toString(),
          radnoVrijeme: radnoVr,
          vlasnik: vlasnikController.text.toString(),
          //administratorId: 1),
        ),
        index: '12'); //widget.citaonicaId.toString());
    return odgovor;
  }
}
