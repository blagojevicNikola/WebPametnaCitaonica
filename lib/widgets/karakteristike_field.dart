import 'package:flutter/material.dart';

class KarakteristikeField extends StatelessWidget {
  final String naziv;
  final Function(String) funkcija;
  const KarakteristikeField(
      {Key? key, required this.naziv, required this.funkcija})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 188, 188, 188),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () {
            funkcija(naziv);
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(
                naziv,
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.add, size: 16),
            ]),
          ),
        ));
  }
}
