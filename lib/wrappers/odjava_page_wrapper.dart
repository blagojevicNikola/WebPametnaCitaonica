import 'package:flutter/material.dart';

import '../pages/odjava_page.dart';

class OdjavaWrapperPage extends StatefulWidget {
  const OdjavaWrapperPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OdjavaWrapperPageState();
  }
}

class _OdjavaWrapperPageState extends State<OdjavaWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Navigator(
          initialRoute: 'odjava',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case 'odjava':
                builder = (BuildContext context) => const OdjavaPage();
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
