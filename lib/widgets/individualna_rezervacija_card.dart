// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:web_aplikacija/models/individualne_rezervacije_mjesta_prikaz.dart';

DateTime defaultTime = DateTime.parse("2000-01-01 00:00:00");

Container _showRemainingTime(DateTime remainingTime, bool otkazana,
    bool potvrdjena, DateTime remainingPotvrdaTime) {
  if (remainingTime != defaultTime && !otkazana && !potvrdjena) {
    if (remainingTime.day < 25) {
      return Container(
          child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text('DO POČETKA:',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                      fontWeight: FontWeight.bold))),
          Container(
            child: Text(
                '${remainingTime.day != 1 ? '${remainingTime.day} dana' : '${remainingTime.day} dan'}\n'
                '${remainingTime.hour}h'
                ' i ${remainingTime.minute}min',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ));
    } else {
      return Container(
          child: Column(
        children: <Widget>[
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text('DO POČETKA:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.bold))),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
                '${remainingTime.hour == 0 ? '' : '${remainingTime.hour}h i '}'
                '${remainingTime.minute}min',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ));
    }
  }

  if (remainingPotvrdaTime != defaultTime && !otkazana && !potvrdjena) {
    if (remainingTime.day < 25) {
      return Container(
          child: Column(
        children: <Widget>[
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text('ROK ZA POTVRDU DOLASKA:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
                '${remainingPotvrdaTime.minute == 0 ? '' : '${remainingPotvrdaTime.minute}min i '}'
                '${remainingPotvrdaTime.second}sec',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ));
    }
  }

  if (otkazana) {
    return Container(
        margin: const EdgeInsets.only(top: 30, left: 5, right: 5),
        child: const Text('OTKAZANA REZERVACIJA',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromARGB(255, 211, 58, 47),
                fontSize: 23,
                fontWeight: FontWeight.bold)));
  }
  if (potvrdjena) {
    return Container(
        margin: const EdgeInsets.only(top: 30, left: 5, right: 5),
        child: Text('ISKORIŠTENA REZERVACIJA',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.green[800],
                fontSize: 23,
                fontWeight: FontWeight.bold)));
  }

  return Container(
      margin: const EdgeInsets.only(top: 30, left: 5, right: 5),
      child: const Text('NEISKORIŠTENA REZERVACIJA',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 23,
              fontWeight: FontWeight.bold)));
}

class IndividualnaRezervacijaKorisnikaCard extends StatelessWidget {
  final IndividualneRezervacijeMjestaPrikaz indRezKorData;

  int index;

  final Function(int) funkcijaBrisanja;
  IndividualnaRezervacijaKorisnikaCard({
    Key? key,
    required this.indRezKorData,
    required this.index,
    required this.funkcijaBrisanja,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sirina = MediaQuery.of(context).size.width;

    bool otkazana = false;
    bool potvrdjena = false;
    if (indRezKorData.vrijemeOtkazivanja != null ||
        indRezKorData.vrijemeVazenjaDo.isBefore(DateTime.now()) ||
        indRezKorData.vrijemePotvrde != null) {
      indRezKorData.vrijemeVazenjaOd =
          indRezKorData.vrijemeVazenjaOd.subtract(const Duration(days: 15));
    }

    if (indRezKorData.vrijemeOtkazivanja != null) {
      otkazana = true;
    }
    if (indRezKorData.vrijemePotvrde != null) {
      potvrdjena = true;
    }

    DateTime sada = DateTime.now();
    DateTime rTime = DateTime.parse("2000-01-01 00:00:00");
    if (sada.isBefore(indRezKorData.vrijemeVazenjaOd)) {
      rTime = indRezKorData.vrijemeVazenjaOd.subtract(
          Duration(days: sada.day, hours: sada.hour, minutes: sada.minute));
    }
    DateTime rPotvrdaTime = DateTime.parse("2000-01-01 00:00:00");
    DateTime krajnjeVrijemePotvrde =
        indRezKorData.vrijemeVazenjaOd.add(const Duration(minutes: 15));
    if (sada.isBefore(krajnjeVrijemePotvrde)) {
      rPotvrdaTime = krajnjeVrijemePotvrde.subtract(Duration(
          days: sada.day,
          hours: sada.hour,
          minutes: sada.minute,
          seconds: sada.second));
    }
    return Container(
      margin: EdgeInsets.only(left: sirina * 0.015, right: sirina * 0.015),
      height: 150,
      //width: 210,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF78AECB),
                  Color(0xFF78AECB),
                ],
              ),
            ),
            //color: Colors.blue[400],
            /*child: Center(
                        child: Text(
                            'Rezervacija ${listaRezervacijaTest[index].citaonica}')),*/
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 35),
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 0.3 * sirina, bottom: 0, top: 10),
                width: 0.3 * sirina,
                child: Text(
                  'Korisničko ime: ${indRezKorData.korisnikKorisnickoIme}\n'
                  'Korisnički email: ${indRezKorData.korisnikMail}\n'
                  'Lokacija: ${indRezKorData.mjestoSalaCitaonicaNaziv}'
                  '\n'
                  'Datum: ${indRezKorData.vrijemeVazenjaOd.day < 10 ? '0${indRezKorData.vrijemeVazenjaOd.day}' : indRezKorData.vrijemeVazenjaOd.day}'
                  '.'
                  '${indRezKorData.vrijemeVazenjaOd.month < 10 ? '0${indRezKorData.vrijemeVazenjaOd.month}' : indRezKorData.vrijemeVazenjaOd.month}'
                  '.'
                  '${indRezKorData.vrijemeVazenjaOd.year}.'
                  '\n'
                  'Vrijeme: ${indRezKorData.vrijemeVazenjaOd.hour < 10 ? '0${indRezKorData.vrijemeVazenjaOd.hour}' : indRezKorData.vrijemeVazenjaOd.hour}'
                  ':'
                  '${indRezKorData.vrijemeVazenjaOd.minute < 10 ? '0${indRezKorData.vrijemeVazenjaOd.minute}' : indRezKorData.vrijemeVazenjaOd.minute}'
                  '-${indRezKorData.vrijemeVazenjaDo.hour < 10 ? '0${indRezKorData.vrijemeVazenjaDo.hour}' : indRezKorData.vrijemeVazenjaDo.hour}'
                  ':'
                  '${indRezKorData.vrijemeVazenjaDo.minute < 10 ? '0${indRezKorData.vrijemeVazenjaDo.minute}' : indRezKorData.vrijemeVazenjaDo.minute}'
                  '\n'
                  'Sala: ${indRezKorData.mjestoSalaOznakaSale}',

                  overflow: TextOverflow.fade,
                  //maxLines: 7,
                  style: const TextStyle(
                      height: 1.1,
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 0.3 * sirina,
                  margin: const EdgeInsets.only(top: 5, bottom: 40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    //child: _getImage(index),
                    child: _showRemainingTime(
                        rTime, otkazana, potvrdjena, rPotvrdaTime),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            width: 0.2 * sirina,
            height: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFb3e7dc)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: const BorderSide(
                                color: Color(0xFFd50102), width: 3)))),
                //  color: const Color(0xFFA72323),
                child: const Text('Otkaži',
                    style: TextStyle(fontSize: 20, color: Color(0xFFd50102))),

                onPressed: () {
                  if (otkazana) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Otkazana rezervacija'),
                              content: const Text(
                                  'Ova rezervacija je već otkazana, ne možete je ponovo otkazati !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }
                  if (potvrdjena &&
                      DateTime.now().isBefore(indRezKorData.vrijemeVazenjaDo)) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Otkazivanje rezervacije'),
                        content: const Text(
                            'Da li ste sigurni da želite otkazati rezervaciju koju ste već potvrdili?\n'
                            'Ako to učinite morate napustiti mjesto i pokupiti svoje stvari !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Otkazivanje rezervacije'),
                                  content: const Text(
                                      'Uspjesno ste otkazali rezervaciju'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        funkcijaBrisanja(index);
                                        var nav = Navigator.of(context);
                                        //Navigator.pop(context, 'OK');
                                        nav.pop();
                                        nav.pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('Da'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Ne'),
                            child: const Text('Ne'),
                          ),
                        ],
                      ),
                    );
                  } else if (potvrdjena &&
                      !DateTime.now()
                          .isBefore(indRezKorData.vrijemeVazenjaDo)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Iskorištena rezervacija'),
                              content: const Text(
                                  'Ova rezervacija je već u potpunosti iskorištena i istekla je, ne možete je više otkazati !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }
                  if (!otkazana &&
                      !potvrdjena &&
                      DateTime.now().isBefore(indRezKorData.vrijemeVazenjaOd)) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Otkazivanje rezervacije'),
                        content: const Text(
                            'Da li ste sigurni da želite otkazati rezervaciju?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Otkazivanje rezervacije'),
                                  content: const Text(
                                      'Uspjesno ste otkazali rezervaciju'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        funkcijaBrisanja(index);
                                        var nav = Navigator.of(context);
                                        //Navigator.pop(context, 'OK');
                                        nav.pop();
                                        nav.pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('Da'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Ne'),
                            child: const Text('Ne'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (!otkazana &&
                      !potvrdjena &&
                      !DateTime.now()
                          .isBefore(indRezKorData.vrijemeVazenjaOd)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Neiskorištena rezervacija'),
                              content: const Text(
                                  'Ova rezervacija je već istekla, ne možete je više otkazati !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
