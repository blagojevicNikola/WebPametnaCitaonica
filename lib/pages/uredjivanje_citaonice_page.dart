import 'dart:html';

import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/individualne_sale_service.dart';
import 'package:web_aplikacija/constants/config.dart';
import 'package:web_aplikacija/models/grupna_sala.dart';
import 'package:web_aplikacija/pages/kreiranje_individualne_sale_page.dart';
import 'package:web_aplikacija/widgets/grupna_sala_tile.dart';
import 'package:web_aplikacija/widgets/individualna_sala_tile.dart';
import 'package:web_aplikacija/widgets/information_field.dart';
import 'package:web_aplikacija/widgets/unos_radnog_vremena.dart';

import '../api/citaonica_service.dart';
import '../api/grupne_sale_service.dart';
import '../models/citaonica.dart';
import '../models/individualna_sala.dart';
import '../widgets/grupna_sala_checkbox.dart';
import '../widgets/supervizor_tile.dart';

class UredjivanjeCitaonicePage extends StatefulWidget {
  Citaonica citData;

  UredjivanjeCitaonicePage({
    required this.citData,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UredjivanjeCitaonicePage();
  }
}

class _UredjivanjeCitaonicePage extends State<UredjivanjeCitaonicePage> {
  var nazivController = TextEditingController();
  var adresaController = TextEditingController();
  var telefonController = TextEditingController();
  var emailController = TextEditingController();
  IndividualneSaleService indSaleService = IndividualneSaleService();
  GrupneSaleService grupSaleService = GrupneSaleService();
  late Future<List<IndividualnaSala>> individualneSaleData;
  late Future<List<GrupnaSala>> grupneSaleData;

  CitaonicaService citService = CitaonicaService();

  @override
  void initState() {
    super.initState();
    individualneSaleData =
        indSaleService.getIndividualneSale(widget.citData.id.toString());
    grupneSaleData =
        grupSaleService.getGrupneSale(widget.citData.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as Citaonica;
    return SingleChildScrollView(
      child: Material(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
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
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 242, 245),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.64,
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
                                control: nazivController =
                                    TextEditingController(
                                        text: widget.citData.name),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'Adresa',
                                control: adresaController =
                                    TextEditingController(
                                        text: widget.citData.adresa),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'E-mail',
                                control: emailController =
                                    TextEditingController(
                                        text: widget.citData.mail),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: InformationField(
                                labelInformation: 'Broj telefona',
                                control: telefonController =
                                    TextEditingController(
                                        text: widget.citData.phoneNumber),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(9),
                                child: Text(
                                  'Radno vrijeme:',
                                  style: TextStyle(
                                      fontSize: 40, color: defaultPlava),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            UnosRadnogVremena(
                                radnoVr: widget.citData.radnoVrijeme),
                            const SizedBox(height: 30),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(9),
                                child: Text(
                                  'Individualne sale:',
                                  style: TextStyle(
                                      fontSize: 40, color: defaultPlava),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder<List<IndividualnaSala>>(
                                future: individualneSaleData,
                                initialData: null,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox(
                                        height: 120,
                                        width: 120,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(9.0),
                                        child: ListView.separated(
                                          itemCount: snapshot.data!.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return IndividiualnaSalaTile(
                                              index: index,
                                              naziv:
                                                  snapshot.data![index].naziv,
                                              brojMjesta: snapshot
                                                  .data![index].brojMjesta,
                                              funkcijaBrisanja:
                                                  obrisiIndividualnuSalu,
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 20,
                                            width: 40,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Text('Empty data');
                                    }
                                  } else {
                                    return Text(
                                        'State: ${snapshot.connectionState}');
                                  }
                                }),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 9.0, 9.0, 9.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      color: const Color.fromARGB(
                                          255, 105, 105, 105),
                                      iconSize: 36,
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            'pregled/citaonica/dodaj_ind');
                                      },
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 30),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(9),
                                child: Text(
                                  'Grupne sale:',
                                  style: TextStyle(
                                      fontSize: 40, color: defaultPlava),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder<List<GrupnaSala>>(
                                future: grupneSaleData,
                                initialData: null,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox(
                                        height: 120,
                                        width: 120,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(9.0),
                                        child: ListView.separated(
                                          itemCount: snapshot.data!.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            GrupnaSala temp =
                                                snapshot.data![index];
                                            return GrupnaSalaTile(
                                              grupnaSalaData: temp,
                                              index: temp.id,
                                              funkcijaBrisanja:
                                                  obrisiGrupnuSalu,
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 20,
                                            width: 40,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Text('Empty data');
                                    }
                                  } else {
                                    return Text(
                                        'State: ${snapshot.connectionState}');
                                  }
                                }),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 9.0, 9.0, 9.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.transparent,
                                    child: IconButton(
                                      color: const Color.fromARGB(
                                          255, 105, 105, 105),
                                      iconSize: 36,
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                      onPressed: () =>
                                          _showGrupnaSalaDialog(widget.citData),
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 30),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(9),
                                child: Text(
                                  'Supervizori:',
                                  style: TextStyle(
                                      fontSize: 40, color: defaultPlava),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: ListView.separated(
                                itemCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return const SupervizorTile(
                                      ime: 'Nikola',
                                      prezime: 'Nikolic',
                                      korisnickoIme: 'nikola_nikolic');
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 20,
                                  width: 40,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 9.0, 9.0, 9.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.transparent,
                                  child: IconButton(
                                      color: const Color.fromARGB(
                                          255, 105, 105, 105),
                                      iconSize: 36,
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            'pregled/citaonica/dodaj_supervizora');
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 207, 55, 55),
                                    ),
                                    overlayColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 241, 114, 114))),
                                child: const Text(
                                  'Obrisi',
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.white),
                                ),
                                onPressed: () {
                                  if (widget.citData.id == null) {
                                    print('Greska');
                                  } else {
                                    obrisiCitaonicu(
                                        widget.citData.id.toString());
                                  }
                                },
                              ),
                            ),
                          ),
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
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 87, 182, 93),
                                    ),
                                    overlayColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 112, 218, 116))),
                                child: const Text(
                                  'Sacuvaj',
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.white),
                                ),
                                onPressed: () {
                                  azurirajCitaonicu(widget.citData);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 30)
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

  void obrisiCitaonicu(String id) {
    citService.deleteCitaonica(citaonicaId: id);
  }

  void azurirajCitaonicu(Citaonica cit) {
    cit.name = nazivController.text.toString();
    cit.adresa = adresaController.text.toString();
    cit.phoneNumber = telefonController.text.toString();
    cit.mail = emailController.text.toString();
    citService.azurirajCitaonicu(citaonicaInfo: cit);
  }

  void obrisiIndividualnuSalu(int? salaIndex) {
    indSaleService.deleteIndividualnaSala(
        citaonicaId: widget.citData.id.toString(),
        individualnaSalaId: salaIndex.toString());
  }

  void obrisiGrupnuSalu(int? salaIndex) {
    grupSaleService.deleteGrupnaSala(
        citaonicaId: widget.citData.id.toString(),
        grupnaSalaId: salaIndex.toString());
  }

  void _showGrupnaSalaDialog(Citaonica citRef) {
    TextEditingController naziv = TextEditingController(text: '');
    TextEditingController qrCode = TextEditingController(text: '');
    TextEditingController brojMjesta = TextEditingController(text: '');
    bool tv;
    bool projektor;
    bool klima;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Text(
                    'Dodaj grupnu salu:',
                    style: TextStyle(
                        color: Color.fromARGB(255, 44, 44, 44), fontSize: 38),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: SizedBox(
                    width: 150,
                    height: 70,
                    child: TextField(
                      controller: naziv,
                      decoration: const InputDecoration(
                        labelText: 'Naziv',
                        labelStyle:
                            TextStyle(color: defaultPlava, fontSize: 23),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: defaultPlava),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: SizedBox(
                    width: 150,
                    height: 70,
                    child: TextField(
                      controller: qrCode,
                      decoration: const InputDecoration(
                        labelText: 'QR Code',
                        labelStyle:
                            TextStyle(color: defaultPlava, fontSize: 23),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: defaultPlava),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: SizedBox(
                    width: 150,
                    height: 70,
                    child: TextField(
                      controller: brojMjesta,
                      decoration: const InputDecoration(
                        labelText: 'Broj mjesta',
                        labelStyle:
                            TextStyle(color: defaultPlava, fontSize: 23),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: defaultPlava),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: GrupnaSalaCheckBox(
                      tv: tv = false,
                      projektor: projektor = false,
                      klima: klima = false),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: TextButton(
                        child: const Text('Sacuvaj'),
                        onPressed: () {
                          // if (naziv.text.isEmpty ||
                          //     qrCode.text.isEmpty ||
                          //     brojMjesta.text.isEmpty) {
                          // } else {
                          //   citRef.grupneSale.add(GrupnaSala(
                          //       tv: tv,
                          //       klima: klima,
                          //       projektor: projektor,
                          //       brojMjesta:
                          //           int.parse(brojMjesta.text.toString()),
                          //       naziv: naziv.text.toString(),
                          //       qrKod: qrCode.text.toString()));
                          //   Navigator.pop(context);
                          // }
                        },
                      )),
                ),
              ],
            ),
          ));
        });
  }
}
