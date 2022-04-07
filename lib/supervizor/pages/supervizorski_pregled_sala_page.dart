import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/grupne_sale_service.dart';
import 'package:web_aplikacija/api/individualne_sale_service.dart';
import 'package:web_aplikacija/models/individualna_sala.dart';
import 'package:web_aplikacija/widgets/grupna_sala_tile.dart';
import 'package:web_aplikacija/widgets/supervizorski_ind_tile.dart';

import '../../api/dio_client.dart';
import '../../constants/config.dart';
import '../../models/grupna_sala.dart';
import '../../widgets/supervizorski_grup_tile.dart';

class SupervizorskiPregledSalaPage extends StatefulWidget {
  const SupervizorskiPregledSalaPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SupervizorskiPregledSalaPageState();
  }
}

class _SupervizorskiPregledSalaPageState
    extends State<SupervizorskiPregledSalaPage> {
  GrupneSaleService grupneSaleService = GrupneSaleService();
  IndividualneSaleService individualneSaleService = IndividualneSaleService();
  DioClient dioCL = DioClient();
  late Future<List<IndividualnaSala>> listaIndividualnihSala;
  late Future<List<GrupnaSala>> listaGrupnihSala;

  @override
  void initState() {
    listaIndividualnihSala =
        individualneSaleService.getIndividualneSale(dioCL, '4');
    listaGrupnihSala = grupneSaleService.getGrupneSale(dioCL, '4');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        width:
                            (MediaQuery.of(context).size.width * 0.64) * 0.78,
                        child: Column(
                          children: [
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
                            FutureBuilder<List<IndividualnaSala>>(
                                future: listaIndividualnihSala,
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
                                            return const SupervizorskiIndTile();
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
                            FutureBuilder<List<GrupnaSala>>(
                                future: listaGrupnihSala,
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
                                            return const SupervizorskaGrupTile();
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
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
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
