import 'package:flutter/material.dart';

import '../pages/dodavanje_citaonice_page.dart';

class DodavanjeCitaoniceWrapperPage extends StatefulWidget {
  const DodavanjeCitaoniceWrapperPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DodavanjeCitaoniceWrapperPageState();
  }
}

class _DodavanjeCitaoniceWrapperPageState
    extends State<DodavanjeCitaoniceWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Navigator(
          initialRoute: 'dodavanje',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case 'dodavanje':
                builder =
                    (BuildContext context) => const DodavanjeCitaonicaPage();
                break;
              default:
                throw Exception('Invalid route:}');
            }
            return MaterialPageRoute<void>(
                builder: builder, settings: settings);
          }),
    );
  }
}
