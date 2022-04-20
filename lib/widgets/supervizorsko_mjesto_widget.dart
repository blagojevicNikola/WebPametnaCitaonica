import 'package:flutter/material.dart';
import 'dart:math' as math;

class SupervizorskoMjestoWidget extends StatelessWidget {
  const SupervizorskoMjestoWidget(
      {Key? key,
      required this.index,
      required this.velicina,
      required this.ugao,
      required this.id})
      : super(key: key);

  final int id;
  final int index;
  final double velicina;
  final int ugao;
  //final Mjesto mjestoDat;

  @override
  Widget build(BuildContext context) {
    return buildIcon();
  }

  Widget buildIcon() {
    return Stack(children: [
      Transform.rotate(
        angle: ugao * math.pi / 180,
        child: Icon(Icons.event_seat,
            color: const Color.fromARGB(255, 88, 88, 88), size: velicina),
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
        ),
      )
    ]);
  }
}
