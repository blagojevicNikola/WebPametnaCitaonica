import 'package:flutter/material.dart';
import 'package:web_aplikacija/models/argumenti_supervizorske_izmjene_individualne_sale.dart';

import '../constants/config.dart';
import '../models/individualna_sala.dart';

class SupervizorskiIndTile extends StatelessWidget {
  final IndividualnaSala indSalaData;
  final int citaonicaId;
  const SupervizorskiIndTile({
    required this.indSalaData,
    required this.citaonicaId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
        ),
        width: double.infinity,
        height: 60,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                  child: Text(
                    indSalaData.naziv,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 105, 105, 105),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                      child: Text(
                        indSalaData.brojMjesta.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: defaultKarakteristike,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 9, 0),
                      child: Icon(
                        Icons.person,
                        size: 24,
                        color: defaultKarakteristike,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                      child: Material(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.transparent,
                        child: IconButton(
                          color: const Color.fromARGB(255, 105, 105, 105),
                          splashRadius: 25,
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                'pregled_individualne_sale',
                                arguments:
                                    ArgSupervizorskeIzmjeneIndividualneSale(
                                        brojMjestaUSali:
                                            indSalaData.brojMjesta!,
                                        nazivIndividualneSale:
                                            indSalaData.naziv,
                                        individualnaSalaId: indSalaData.id!,
                                        citaonicaId: citaonicaId));
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
