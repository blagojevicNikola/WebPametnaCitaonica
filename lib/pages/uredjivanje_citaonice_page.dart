import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/individualne_sale_service.dart';
import 'package:web_aplikacija/api/supervizor_service.dart';
import 'package:web_aplikacija/constants/config.dart';
import 'package:web_aplikacija/models/grupna_sala.dart';
import 'package:web_aplikacija/widgets/grupna_sala_tile.dart';
import 'package:web_aplikacija/widgets/individualna_sala_tile.dart';
import 'package:web_aplikacija/widgets/information_field.dart';
import 'package:web_aplikacija/widgets/unos_radnog_vremena.dart';

import '../api/citaonica_service.dart';
import '../api/dio_client.dart';
import '../api/grupne_sale_service.dart';
import '../models/citaonica.dart';
import '../models/individualna_sala.dart';
import '../models/nalog.dart';
import '../models/radno_vrijeme.dart';
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
  SupervizorService supervizorService = SupervizorService();
  late Future<List<IndividualnaSala>> individualneSaleData;
  late Future<List<GrupnaSala>> grupneSaleData;
  late Future<List<Nalog>> supervizoriData;

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
  DioClient dioCL = DioClient();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < radnoVr.length; i++) {
      int pozicija = widget.citData.radnoVrijeme
          .indexWhere((element) => element.id == i + 1);
      if (pozicija != -1) {
        radnoVr[i].pocetak = widget.citData.radnoVrijeme[pozicija].pocetak;
        radnoVr[i].kraj = widget.citData.radnoVrijeme[pozicija].kraj;
      }
    }
    individualneSaleData =
        indSaleService.getIndividualneSale(dioCL, widget.citData.id.toString());
    grupneSaleData =
        grupSaleService.getGrupneSale(dioCL, widget.citData.id.toString());
    supervizoriData =
        supervizorService.getSupervizore(dioCL, widget.citData.id.toString());
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
                            UnosRadnogVremena(radnoVr: radnoVr),
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
                                              citaonicaId: widget.citData.id!,
                                              index: snapshot.data![index].id,
                                              individualnaSalaData:
                                                  snapshot.data![index],
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
                                            'pregled/citaonica/dodaj_ind',
                                            arguments: widget.citData.id);
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
                                              citaonicaId:
                                                  widget.citData.id.toString(),
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
                                      onPressed: () => {
                                        Navigator.of(context).pushNamed(
                                            'pregled/citaonica/dodaj_grup',
                                            arguments: widget.citData.id)
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
                                  'Supervizori:',
                                  style: TextStyle(
                                      fontSize: 40, color: defaultPlava),
                                ),
                              ),
                            ),
                            FutureBuilder<List<Nalog>>(
                                future: supervizoriData,
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
                                            return SupervizorTile(
                                              id: snapshot.data![index].id!,
                                              ime: snapshot.data![index].ime,
                                              prezime:
                                                  snapshot.data![index].prezime,
                                              korisnickoIme: snapshot
                                                  .data![index].korisnickoIme,
                                              funkcijaBrisanja:
                                                  obrisiSupervizora,
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
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            'pregled/citaonica/dodaj_supervizora',
                                            arguments: widget.citData.id);
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
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
                                  onPressed: () async {
                                    final response =
                                        await citService.deleteCitaonica(
                                            dioClient: dioCL,
                                            citaonicaId:
                                                widget.citData.id.toString());
                                    if (response != null) {
                                      if (response.statusCode == 200) {
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  }),
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
                                onPressed: () async {
                                  Citaonica temp =
                                      azurirajCitaonicu(widget.citData);
                                  citService.azurirajCitaonicu(
                                      dioClient: dioCL,
                                      citaonicaInfo: temp,
                                      index: widget.citData.id.toString());
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
    citService.deleteCitaonica(dioClient: dioCL, citaonicaId: id);
  }

  void posaljiAzuriranje(Citaonica cit, String index) async {
    Citaonica temp = Citaonica(
        name: cit.name,
        adresa: cit.adresa,
        radnoVrijeme: cit.radnoVrijeme,
        opis: cit.opis,
        vlasnik: cit.vlasnik,
        phoneNumber: cit.phoneNumber,
        administratorId: cit.administratorId,
        mail: cit.mail);
    citService.azurirajCitaonicu(
        dioClient: dioCL, citaonicaInfo: temp, index: index);
  }

  Citaonica azurirajCitaonicu(Citaonica cit) {
    radnoVr.removeWhere(radnoVrijemeIsNull);
    return Citaonica(
        name: nazivController.text.toString(),
        adresa: adresaController.text.toString(),
        radnoVrijeme: radnoVr,
        opis: cit.opis,
        vlasnik: cit.vlasnik,
        phoneNumber: telefonController.text.toString(),
        administratorId: cit.administratorId,
        mail: emailController.text.toString());
  }

  bool radnoVrijemeIsNull(RadnoVrijemeUDanu element) {
    if (element.id == null || element.pocetak == null || element.kraj == null) {
      return true;
    } else {
      return false;
    }
  }

  void obrisiIndividualnuSalu(int? salaIndex) async {
    final brisanje = await indSaleService.deleteIndividualnaSala(
        dioClient: dioCL,
        citaonicaId: widget.citData.id.toString(),
        individualnaSalaId: salaIndex.toString());
    if (brisanje.isEmpty) {
      setState(() {
        individualneSaleData = indSaleService.getIndividualneSale(
            dioCL, widget.citData.id.toString());
      });
    }
  }

  void obrisiGrupnuSalu(int? salaIndex) async {
    final brisanje = await grupSaleService.deleteGrupnaSala(
        dioClient: dioCL,
        citaonicaId: widget.citData.id.toString(),
        grupnaSalaId: salaIndex.toString());
    if (brisanje.isEmpty) {
      setState(() {
        grupneSaleData =
            grupSaleService.getGrupneSale(dioCL, widget.citData.id.toString());
      });
    }
  }

  void obrisiSupervizora(int? supervizorId) async {
    final brisanje = await supervizorService.deleteSupervizor(
        dioClient: dioCL,
        citaonicaId: widget.citData.id.toString(),
        supervizorId: supervizorId.toString());
    if (brisanje != null) {
      if (brisanje.statusCode == 204) {
        setState(() {
          supervizoriData = supervizorService.getSupervizore(
              dioCL, widget.citData.id.toString());
        });
      }
    }
  }
}
