import 'package:flutter/material.dart';

import 'package:web_aplikacija/models/citaonica.dart';
import 'package:web_aplikacija/models/grupna_sala.dart';
import 'package:web_aplikacija/pages/dodavanje_supervizora_page.dart';
import 'package:web_aplikacija/pages/kreiranje_grupne_sale.dart';
import 'package:web_aplikacija/pages/kreiranje_individualne_sale_page.dart';
import 'package:web_aplikacija/pages/pregled_citaonica_page.dart';
import 'package:web_aplikacija/pages/uredjivanje_citaonice_page.dart';

import '../pages/izmjena_grupne_sale_page.dart';
import '../pages/izmjena_individualne_sale.dart';

class PregledCitaonicaWrapperPage extends StatefulWidget {
  const PregledCitaonicaWrapperPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PregledCitaonicaWrapperPageState();
  }
}

class _PregledCitaonicaWrapperPageState
    extends State<PregledCitaonicaWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Navigator(
          initialRoute: 'pregled',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case 'pregled':
                builder = (BuildContext context) => PregledCitaonicaPage();
                break;
              case 'pregled/citaonica':
                builder = (BuildContext context) => UredjivanjeCitaonicePage(
                    citData: settings.arguments as Citaonica);
                break;
              case 'pregled/citaonica/dodaj_ind':
                builder =
                    (BuildContext context) => KreiranjeIndivividualneSalePage(
                          citaonicaId: settings.arguments as int,
                        );
                break;
              case 'pregled/citaonica/izmjeni_ind':
                builder = (BuildContext context) => IzmjenaIndividualneSalePage(
                    individualnaSalaId: settings.arguments as int);
                break;
              case 'pregled/citaonica/izmjeni_grup':
                builder = (BuildContext context) => IzmjenaGrupneSalePage(
                      grupnaSalaData: settings.arguments as GrupnaSala,
                    );
                break;
              case 'pregled/citaonica/dodaj_supervizora':
                builder = (BuildContext context) => DodavanjeSupervizoraPage();
                break;
              case 'pregled/citaonica/dodaj_grup':
                builder = (BuildContext context) => KreiranjeGrupneSalePage(
                      citaonicaId: settings.arguments as int,
                    );
                break;
              default:
                throw Exception('Invalid route:}');
            }
            return MaterialPageRoute<void>(
                builder: builder, settings: settings, maintainState: false);
          }),
    );
  }
}
