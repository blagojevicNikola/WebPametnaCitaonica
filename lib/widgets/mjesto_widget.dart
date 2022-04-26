import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/mjesto.dart';

class MjestoWidget extends StatelessWidget {
  const MjestoWidget({
    Key? key,
    required this.onDragEnd,
    required this.index,
    required this.mjestoDat,
    required this.obrisiMjesto,
    required this.opcijaBrisanjaUkljucena,
  }) : super(key: key);

  final void Function(Offset, int) onDragEnd;
  final void Function(int) obrisiMjesto;
  final bool opcijaBrisanjaUkljucena;
  final int index;
  final Mjesto mjestoDat;

  @override
  Widget build(BuildContext context) {
    return (opcijaBrisanjaUkljucena == false)
        ? Draggable(
            child: buildIcon(),
            feedback: buildIcon(),
            onDraggableCanceled: (velocity, drag) {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              onDragEnd(renderBox.globalToLocal(drag), index);
            },
          )
        : InkWell(onTap: () => obrisiMjesto(index), child: buildIcon());
  }

  Widget buildIcon() {
    return Stack(
      children: [
        Transform.rotate(
          angle: mjestoDat.ugao * math.pi / 180,
          child: Icon(Icons.event_seat,
              color: const Color.fromARGB(255, 88, 88, 88),
              size: mjestoDat.velicina.toDouble()),
        ),
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            width: mjestoDat.velicina * 0.4,
            height: mjestoDat.velicina * 0.4,
            child: Text(
              '${mjestoDat.brojMjesta}',
              style: TextStyle(
                color: Colors.white,
                fontSize: mjestoDat.velicina * 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
