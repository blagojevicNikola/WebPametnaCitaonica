import 'package:flutter/material.dart';
import 'dart:math' as math;

class PostojeceMjestoWidget extends StatelessWidget {
  const PostojeceMjestoWidget(
      {Key? key,
      required this.index,
      required this.velicina,
      required this.ugao})
      : super(key: key);

  final int index;
  final int velicina;
  final int ugao;
  //final Mjesto mjestoDat;

  @override
  Widget build(BuildContext context) {
    return buildIcon();
  }

  Widget buildIcon() {
    return Stack(
      children: [
        Transform.rotate(
          angle: ugao * math.pi / 180,
          child: Icon(Icons.event_seat,
              color: const Color.fromARGB(255, 88, 88, 88),
              size: velicina.toDouble()),
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
