import 'package:flutter/material.dart';

class SupervizorTile extends StatelessWidget {
  final int id;
  final String ime;
  final String prezime;
  final String korisnickoIme;
  final Function(int?) funkcijaBrisanja;
  const SupervizorTile(
      {Key? key,
      required this.id,
      required this.ime,
      required this.prezime,
      required this.korisnickoIme,
      required this.funkcijaBrisanja})
      : super(key: key);

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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                    child: RichText(
                      text: TextSpan(
                        text: ime,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 105, 105, 105),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' $prezime',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 105, 105, 105),
                            ),
                          ),
                          TextSpan(
                            text: ' ($korisnickoIme)',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 105, 105, 105),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                      child: Material(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.transparent,
                        child: IconButton(
                          color: const Color.fromARGB(255, 105, 105, 105),
                          splashRadius: 25,
                          icon: const Icon(Icons.lock),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                      child: Material(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.transparent,
                        child: IconButton(
                          hoverColor: const Color.fromARGB(255, 224, 110, 102),
                          splashColor: const Color.fromARGB(255, 235, 61, 48),
                          color: const Color.fromARGB(255, 105, 105, 105),
                          splashRadius: 25,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            funkcijaBrisanja(id);
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
