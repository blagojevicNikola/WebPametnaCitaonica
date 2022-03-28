import 'package:flutter/material.dart';

class Obavjestenje {
  int idObavjestenja;
  int idSupervizora;
  String naslov;
  String tekstNotifikacije;

  Obavjestenje(this.idObavjestenja, this.idSupervizora, this.naslov,
      this.tekstNotifikacije);
}

class SlanjeNotifikacija extends StatefulWidget {
  const SlanjeNotifikacija({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SlanjeNotifikacijaState();
  }
}

class _SlanjeNotifikacijaState extends State<SlanjeNotifikacija> {
  // double sirina = MediaQuery.of(context).size.width;
  late Obavjestenje obavjestenje;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFFD6F4F3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.18,
                right: MediaQuery.of(context).size.width * 0.18,
                top: 15,
                bottom: 10),
            child: TextFormField(
              onChanged: (text) {
                obavjestenje.naslov = text;
              },
              decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.email, color: Colors.blue[700]),
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(),
                  //labelText: 'Naslov',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  hintText: 'Unesite naslov obavještenja'),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.18,
                right: MediaQuery.of(context).size.width * 0.18,
                top: 15,
                bottom: 10),
            child: TextFormField(
              maxLines: 10,
              onChanged: (text) {
                obavjestenje.tekstNotifikacije = text;
              },
              decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(),
                  //labelText: 'Tekst obavještenja',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  hintText: 'Unesite tekst obavještenja'),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              // color: Color.fromARGB(255, 5, 89, 214),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.64,
          )
        ],
      ),
    ));
  }
}
