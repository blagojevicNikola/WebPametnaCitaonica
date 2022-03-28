import 'package:flutter/material.dart';
import 'package:web_aplikacija/supervizor/pages/supervizorski_pregled_sala_page.dart';

class SupervizorskiPregledSaleWrapper extends StatelessWidget {
  const SupervizorskiPregledSaleWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Navigator(
          initialRoute: 'pregled_sala',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case 'pregled_sala':
                builder = (BuildContext context) =>
                    const SupervizorskiPregledSalaPage();
                break;

              default:
                throw Exception('Invalid route:');
            }
            return MaterialPageRoute<void>(
                builder: builder, settings: settings, maintainState: false);
          }),
    );
  }
}