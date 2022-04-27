import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:web_aplikacija/widgets/individualne_rezervacije_mjesta.dart';

import '../models/mjesto.dart';

class SupervizorskoMjestoWidget extends StatelessWidget {
  const SupervizorskoMjestoWidget(
      {Key? key,
      required this.index,
      required this.mjestoData,
      required this.velicina,
      required this.funkcijaZakljucavanjaMjesta})
      : super(key: key);

  final int index;
  final double velicina;
  final Mjesto mjestoData;
  final Function(Mjesto, bool) funkcijaZakljucavanjaMjesta;
  //final Mjesto mjestoDat;

  @override
  Widget build(BuildContext context) {
    return buildIcon(context);
  }

  Widget buildIcon(BuildContext context) {
    return Stack(children: [
      Transform.rotate(
        angle: mjestoData.ugao * math.pi / 180,
        child: InkWell(
          onTap: () {
            //print('Milosa Skobica cekam!');
            /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const IndividualneRezervacijeMjesta()));*/
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => IndividualneRezervacijeMjesta(
                mjestoData: mjestoData,
                funkcijaZakljucavanjaMjesta: funkcijaZakljucavanjaMjesta,
              ),
            );
          },
          child: Icon(Icons.event_seat,
              color: (mjestoData.dostupno == false)
                  ? const Color.fromARGB(255, 243, 210, 79)
                  : const Color.fromARGB(255, 88, 88, 88),
              size: velicina),
        ),
      ),
      Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            width: velicina * 0.4,
            height: velicina * 0.4,
            child: Text(
              '$index',
              style: TextStyle(
                color: Colors.white,
                fontSize: velicina * 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          )),
    ]);
  }
}
