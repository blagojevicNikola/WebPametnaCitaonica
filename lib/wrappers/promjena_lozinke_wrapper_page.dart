import 'package:flutter/material.dart';

import '../pages/promjena_lozinke_page.dart';

class PromjenaLozinkeWrapperPage extends StatefulWidget {
  const PromjenaLozinkeWrapperPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PromjenaLozinkeWrapperPageState();
  }
}

class _PromjenaLozinkeWrapperPageState
    extends State<PromjenaLozinkeWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Navigator(
          initialRoute: 'promjena_lozinke',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case 'promjena_lozinke':
                builder = (BuildContext context) => const PromjenaLozinkePage();
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
