import 'package:flutter/material.dart';
import 'package:web_aplikacija/constants/config.dart';

class InformationField extends StatefulWidget {
  final String labelInformation;
  final TextEditingController control;
  const InformationField(
      {Key? key, required this.labelInformation, required this.control})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InformationFieldState();
  }
}

class _InformationFieldState extends State<InformationField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.64) * 0.78,
      child: TextFormField(
        controller: widget.control,
        style:
            const TextStyle(fontSize: 18.0, height: 1.65, color: Colors.black),
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        maxLength: 50,
        decoration: InputDecoration(
          labelText: widget.labelInformation,
          labelStyle: const TextStyle(color: defaultPlava, fontSize: 23),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: defaultPlava),
          ),
        ),
      ),
    );
  }
}
