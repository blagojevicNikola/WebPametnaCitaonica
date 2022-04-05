import 'package:flutter/material.dart';
import 'package:web_aplikacija/api/citaonica_service.dart';
import 'package:web_aplikacija/constants/citaonica_const.dart';

import '../api/dio_client.dart';
import '../models/citaonica.dart';
import '../widgets/citaonica_card.dart';

class PregledCitaonicaPage extends StatefulWidget {
  const PregledCitaonicaPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PregledCitaonicaPageState();
  }
}

class _PregledCitaonicaPageState extends State<PregledCitaonicaPage> {
  CitaonicaService citService = CitaonicaService();
  DioClient dioCL = DioClient();

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
              children: const [
                SizedBox(height: 50),
                Divider(
                  height: 80,
                  color: Color.fromARGB(255, 177, 211, 240),
                  thickness: 2,
                  indent: 18,
                  endIndent: 18,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 9, 9, 9),
                  child: Text('Čitaonice',
                      style: TextStyle(
                          fontSize: 48,
                          color: Color.fromARGB(255, 105, 105, 105),
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 242, 245),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.64,
                  child: FutureBuilder<List<Citaonica>>(
                      future: citService.getCitaonice(dioCL),
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
                            return Column(
                              children: [
                                const SizedBox(height: 50),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return CitaonicaCard(
                                          snapshot.data![index]);
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
}
