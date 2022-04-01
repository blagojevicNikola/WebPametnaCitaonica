import 'package:flutter/material.dart';

import '../api/mjesta_service.dart';
import '../models/mjesto.dart';
import '../widgets/postojece_mjesto_widget.dart';

class IzmjenaIndividualneSalePage extends StatefulWidget {
  //final List<Mjesto> listaPostojecihMjesta;
  int individualnaSalaId;
  IzmjenaIndividualneSalePage({Key? key, required this.individualnaSalaId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IzmjenaIndividualneSalePageState();
  }
}

class _IzmjenaIndividualneSalePageState
    extends State<IzmjenaIndividualneSalePage> {
  MjestaService mjestaService = MjestaService();
  late final Future<List<Mjesto>> listaPostojecihMjesta;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FutureBuilder<List<Mjesto>>(
            future:
                mjestaService.getMjesta(widget.individualnaSalaId.toString()),
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                    height: 120,
                    width: 120,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Stack(
                    children: [
                      Positioned(
                        top: 14,
                        child: Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              child: const Text('Nazad'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )),
                      ),
                      Positioned(
                        top: 14,
                        left: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: const Text('Dodaj sliku'),
                              onPressed: () {},
                            ),
                            TextButton(
                              child: const Text('Ukloni sliku'),
                              onPressed: () {},
                            ),
                            TextButton(
                                child: const Text('Dodaj mjesto'),
                                onPressed: () {}),
                            const SizedBox(width: 30),
                            Row(
                              children: const [
                                Text('Velicina: '),
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    style: TextStyle(fontSize: 19, height: 1.1),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: const [
                                Text('Ugao: '),
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    style: TextStyle(fontSize: 19, height: 1.1),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: const [
                                Text('QR code: '),
                                SizedBox(
                                  width: 150,
                                  child: TextField(
                                    style: TextStyle(fontSize: 19, height: 1.1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: const [
                                Text('Broj: '),
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    style: TextStyle(fontSize: 19, height: 1.1),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Text('Naziv sale: '),
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    style: TextStyle(fontSize: 19, height: 1.1),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      for (var item in snapshot.data!)
                        Positioned(
                          left: item.pozicija.x,
                          top: item.pozicija.y,
                          child: PostojeceMjestoWidget(
                            index: item.brojMjesta,
                            velicina: item.velicina,
                            ugao: item.ugao,
                          ),
                        ),
                      Positioned(
                          bottom: 10,
                          right: 10,
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
                          ))
                    ],
                  );
                } else {
                  return const Center(child: Text('Greska'));
                }
              } else {
                return const Center(child: Text('Greska'));
              }
            }));
  }
}
