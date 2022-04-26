import 'package:flutter/material.dart';
import 'dart:math' as math;

class PostojeceMjestoWidget extends StatelessWidget {
  const PostojeceMjestoWidget({
    Key? key,
    required this.index,
    required this.velicina,
    required this.ugao,
    required this.funkcijaBrisanjaMjesta,
    required this.opcijaBrisanjaUkljucena,
    required this.idMjesta,
  }) : super(key: key);

  final int index;
  final int idMjesta;
  final double velicina;
  final int ugao;
  final Function(int) funkcijaBrisanjaMjesta;
  final bool opcijaBrisanjaUkljucena;
  //final Mjesto mjestoDat;

  @override
  Widget build(BuildContext context) {
    return (opcijaBrisanjaUkljucena == true)
        ? InkWell(
            child: buildIcon(), onTap: () => funkcijaBrisanjaMjesta(idMjesta))
        : buildIcon();
  }

  Widget buildIcon() {
    return Stack(
      children: [
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
          ),
        )
      ],
    );
  }
}
