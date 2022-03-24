import 'package:flutter/material.dart';

class GrupnaSalaCheckBox extends StatefulWidget {
  bool tv;
  bool projektor;
  bool klima;

  GrupnaSalaCheckBox(
      {Key? key,
      required this.tv,
      required this.projektor,
      required this.klima})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GrupnaSalaCHeckBoxState();
  }
}

class _GrupnaSalaCHeckBoxState extends State<GrupnaSalaCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const Text('Tv: '),
            Checkbox(
              value: widget.tv,
              onChanged: (bool? value) {
                setState(
                  () {
                    widget.tv = value!;
                  },
                );
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text('Projektor: '),
            Checkbox(
              value: widget.projektor,
              onChanged: (bool? value) {
                setState(
                  () {
                    widget.projektor = value!;
                  },
                );
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text('Klima: '),
            Checkbox(
              value: widget.klima,
              onChanged: (bool? value) {
                setState(
                  () {
                    widget.klima = value!;
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
