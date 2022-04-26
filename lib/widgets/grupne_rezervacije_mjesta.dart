import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/api/prikaz_grupnih_rezervacija_sale_service.dart';
import 'package:web_aplikacija/api/prikaz_individualnih_rezervacija_mjesta_service.dart';
import 'package:web_aplikacija/models/argumenti_prikaza_individualne_rezervacije_mjesta.dart';
import 'package:web_aplikacija/models/grupne_rezervacije_mjesta_prikaz.dart';
import 'package:web_aplikacija/models/individualne_rezervacije_mjesta_prikaz.dart';
import 'package:web_aplikacija/models/karakteristike.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';
import 'package:web_aplikacija/widgets/grupna_rezervacija_card.dart';
import 'package:web_aplikacija/widgets/individualna_rezervacija_card.dart';

import 'karakteristike_field.dart';

class GrupneRezervacijeMjesta extends StatefulWidget {
  int? idSale;
  String oznakaSale;
  GrupneRezervacijeMjesta({
    required this.idSale,
    required this.oznakaSale,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GrupneRezervacijeMjestaState();
  }
}

class _GrupneRezervacijeMjestaState extends State<GrupneRezervacijeMjesta> {
  late Future<List<GrupneRezervacijeSalePrikaz>> listaRezervacija;
  DioClient dioCl = DioClient();

  PrikazGrupnihRezervacijaSaleService prikazGrupnihRezervacijaSaleService =
      PrikazGrupnihRezervacijaSaleService();

  @override
  void initState() {
    listaRezervacija = prikazGrupnihRezervacijaSaleService.getGrupRezSale(
        DateTime.now().subtract(const Duration(days: 20)),
        DateTime.now().add(const Duration(days: 20)),
        dioCl,
        widget.idSale as int);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.18,
        right: MediaQuery.of(context).size.width * 0.18,
      ),
      child: SingleChildScrollView(
        child: Dialog(
            child: Column(
          children: [
            Text(
              '\nRezervacije za salu: ${widget.oznakaSale}',
              style: const TextStyle(fontSize: 25, color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FutureBuilder<List<GrupneRezervacijeSalePrikaz>>(
                  future: listaRezervacija,
                  initialData: null,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                          height: 120,
                          width: 120,
                          child: Center(child: CircularProgressIndicator()));
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData &&
                          snapshot.data.toString() != '[]') {
                        List<GrupneRezervacijeSalePrikaz>? list =
                            snapshot.data?.toList();

                        for (int i = 0; i < list!.length; i++) {
                          if (list[i].vrijemeOtkazivanja != null ||
                              (list[i]
                                  .vrijemeVazenjaDo
                                  .isBefore(DateTime.now())) ||
                              list[i].vrijemePotvrde != null) {
                            list[i].vrijemeVazenjaOd = list[i]
                                .vrijemeVazenjaOd
                                .add(const Duration(days: 15));
                          }
                        }
                        list.sort((a, b) =>
                            a.vrijemeVazenjaOd.compareTo(b.vrijemeVazenjaOd));
                        return Column(
                          children: [
                            const SizedBox(height: 50),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GrupnaRezervacijaKorisnikaCard(
                                    grupRezKorData: list[index],
                                    // index: snapshot.data![index].id,
                                    index: list[index].id,
                                    funkcijaBrisanja:
                                        obrisiGrupnuRezervacijuKorisnika,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 40,
                                      width: 40,
                                    ),
                                itemCount: snapshot.data!.length),
                            const SizedBox(height: 40),
                          ],
                        );
                      } else {
                        return Center(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 300,
                              child: const Text(
                                'Trenutno nema rezervacija za prikazati !',
                                style: TextStyle(fontSize: 30),
                              )),
                        );
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  }),
            ),
          ],
        )),
      ),
    );
  }

  void obrisiGrupnuRezervacijuKorisnika(int ind) async {
    var response = await prikazGrupnihRezervacijaSaleService.deleteRezervacija(
        salaId: widget.idSale as int, dioClient: dioCl, rezervacijaId: ind);
    if (response.statusCode == 200 || response.statusCode == 204) {
      setState(() {
        listaRezervacija = prikazGrupnihRezervacijaSaleService.getGrupRezSale(
            DateTime.now().subtract(const Duration(days: 20)),
            DateTime.now().add(const Duration(days: 20)),
            dioCl,
            widget.idSale as int);
      });
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Greška'),
          content: const Text('Greška prilikom brisanja !',
              style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Da'),
            ),
          ],
        ),
      );

      setState(() {
        listaRezervacija = prikazGrupnihRezervacijaSaleService.getGrupRezSale(
            DateTime.now().subtract(const Duration(days: 20)),
            DateTime.now().add(const Duration(days: 20)),
            dioCl,
            widget.idSale as int);
      });
    }
  }
}
