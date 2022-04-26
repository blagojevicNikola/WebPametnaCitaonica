import 'package:flutter/material.dart';
import 'package:web_aplikacija/supervizor/pages/promjena_informacija_citaonice.dart';

class SupervizorskaIzmjenaCitaoniceWrapperPage extends StatefulWidget {
  const SupervizorskaIzmjenaCitaoniceWrapperPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SupervizorskaIzmjenaCitaoniceWrapperPageState();
  }
}

class _SupervizorskaIzmjenaCitaoniceWrapperPageState
    extends State<SupervizorskaIzmjenaCitaoniceWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Navigator(
          initialRoute: 'promjena',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case 'promjena':
                builder = (BuildContext context) =>
                    const PromjenaInformacijaCitaonice();
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
