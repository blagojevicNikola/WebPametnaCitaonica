import 'package:flutter/material.dart';
import 'package:web_aplikacija/widgets/supervizorski_ind_tile.dart';

import '../../constants/config.dart';
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
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: ListView.separated(
                                itemCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return const SupervizorskiIndTile();
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 20,
                                  width: 40,
                                ),
                              ),
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
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: ListView.separated(
                                itemCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return const SupervizorskaGrupTile();
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 20,
                                  width: 40,
                                ),
                              ),
                            ),
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
