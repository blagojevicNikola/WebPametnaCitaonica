import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api/dio_client.dart';
import '../api/supervizor_service.dart';

class SupervizorTile extends StatefulWidget {
  final int id;
  final String ime;
  final String prezime;
  final String korisnickoIme;
  bool? zakljucan;
  final Function(int?) funkcijaBrisanja;
  SupervizorTile(
      {Key? key,
      required this.id,
      required this.ime,
      required this.prezime,
      required this.korisnickoIme,
      this.zakljucan,
      required this.funkcijaBrisanja})
      : super(key: key);

  @override
  State<SupervizorTile> createState() => _SupervizorTileState();
}

class _SupervizorTileState extends State<SupervizorTile> {
  SupervizorService supervizorService = SupervizorService();
  DioClient dioCL = DioClient();

  late bool nalogZakljucan;

  @override
  void initState() {
    nalogZakljucan = widget.zakljucan!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: nalogZakljucan == true
              ? const Color.fromARGB(255, 222, 222, 222)
              : Colors.white,
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
                        text: widget.ime,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 105, 105, 105),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ${widget.prezime}',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 105, 105, 105),
                            ),
                          ),
                          TextSpan(
                            text: ' (${widget.korisnickoIme})',
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
                          hoverColor: (nalogZakljucan == true)
                              ? const Color.fromARGB(255, 118, 198, 122)
                              : const Color.fromARGB(255, 224, 110, 102),
                          splashColor: (nalogZakljucan == true)
                              ? const Color.fromARGB(255, 57, 218, 65)
                              : const Color.fromARGB(255, 235, 61, 48),
                          color: const Color.fromARGB(255, 105, 105, 105),
                          splashRadius: 25,
                          icon: nalogZakljucan == true
                              ? const Icon(Icons.lock_open)
                              : const Icon(Icons.lock_outline),
                          onPressed: () async {
                            await zakljucajSupervizora(
                                widget.id, !widget.zakljucan!);
                          },
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
                            widget.funkcijaBrisanja(widget.id);
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

  Future<void> zakljucajSupervizora(int nalogId, bool zakljucaj) async {
    Response? temp = await supervizorService.zakljucajSupervizora(
        dioClient: dioCL, zakljucaj: zakljucaj, nalogId: nalogId.toString());
    if (temp != null) {
      if (temp.statusCode == 200) {
        widget.zakljucan = zakljucaj;
        setState(() {
          nalogZakljucan = zakljucaj;
        });
      }
    }
  }
}
