import 'package:flutter/material.dart';
import 'package:web_aplikacija/models/radno_vrijeme.dart';

import '../models/dan.dart';

class UnosRadnogVremena extends StatefulWidget {
  final Map<Dan, RadnoVrijemeUDanu?> radnoVr;
  const UnosRadnogVremena({Key? key, required this.radnoVr}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UnosRadnogVremenaState();
  }
}

class _UnosRadnogVremenaState extends State<UnosRadnogVremena> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                children: [
                  Text(
                    Dan.values[index].name,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                      onPressed: () => _izaberiVrijeme(context, 'p', index),
                      child: Text(getVrijeme('p', index))),
                  Container(
                      width: 9, height: 3, color: Colors.grey.withOpacity(0.4)),
                  TextButton(
                      onPressed: () => _izaberiVrijeme(context, 'k', index),
                      child: Text(getVrijeme('k', index))),
                ],
              ));
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
              width: 20,
            ),
        itemCount: Dan.values.length);
  }

  String getVrijeme(String v, int index) {
    if (v == 'p') {
      if (widget.radnoVr.values.elementAt(index)!.pocetak != null) {
        return '${widget.radnoVr.values.elementAt(index)!.pocetak!.hour.toString().padLeft(2, '0')} : ${widget.radnoVr.values.elementAt(index)!.pocetak!.minute.toString().padLeft(2, '0')}';
      } else {
        return 'hh:mm';
      }
    } else {
      if (widget.radnoVr.values.elementAt(index)!.kraj != null) {
        return '${widget.radnoVr.values.elementAt(index)!.kraj!.hour.toString().padLeft(2, '0')} : ${widget.radnoVr.values.elementAt(index)!.kraj!.minute.toString().padLeft(2, '0')}';
      } else {
        return 'hh:mm';
      }
    }
    //return 'hh:mm';
  }

  Future<void> _izaberiVrijeme(
      BuildContext context, String v, int index) async {
    final TimeOfDay? picked = await showTimePicker(
        useRootNavigator: false,
        context: context,
        initialTime: const TimeOfDay(hour: 0, minute: 0),
        initialEntryMode: TimePickerEntryMode.input);

    if (picked == null) {
      return;
    } else {
      if (v == 'p') {
        setState(
          () {
            widget.radnoVr.values.elementAt(index)!.pocetak = picked;
          },
        );
      } else {
        setState(
          () {
            widget.radnoVr.values.elementAt(index)!.kraj = picked;
          },
        );
      }
    }
  }
}
