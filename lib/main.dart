import 'package:flutter/material.dart';
import 'package:web_aplikacija/pages/login_page.dart';
import 'package:web_aplikacija/supervizor/supervizor_home_page.dart';
import 'package:web_aplikacija/wrappers/dodavanje_citaonice_wrapper_page.dart';
import 'package:web_aplikacija/wrappers/odjava_page_wrapper.dart';
import 'package:web_aplikacija/wrappers/pregled_citaonica_page_wrapper.dart';
import 'package:web_aplikacija/wrappers/promjena_lozinke_wrapper_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const LoginDemo(), debugShowCheckedModeBanner: false,
        //home: const MyHomePage(title: 'Administratorska app'),
        routes: {'login': (context) => const LoginDemo()});
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    const Pregled(),
    const Dodavanje(),
    const Lozinka(),
    const Odjava()
  ];
  @override
  Widget build(BuildContext context) {
    //double visina = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            groupAlignment: -1,
            //minWidth: 120,
            backgroundColor: const Color.fromARGB(255, 177, 211, 240),
            selectedIndex: _selectedIndex,
            selectedIconTheme: const IconThemeData(
                size: 40, color: Color.fromARGB(255, 100, 100, 100)),
            selectedLabelTextStyle: const TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 100, 100, 100),
                fontWeight: FontWeight.bold),
            unselectedLabelTextStyle:
                const TextStyle(color: Colors.white, fontSize: 24),
            unselectedIconTheme:
                const IconThemeData(size: 40, color: Colors.white),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            //groupAlignment: 1.0,

            extended: false,
            labelType: NavigationRailLabelType.all,
            leading: Column(
              children: const [
                SizedBox(height: 10),
                Icon(Icons.person, color: Colors.white, size: 25),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                  child: Text('Administrator',
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
                SizedBox(height: 10),
              ],
            ),
            elevation: 1,
            destinations: const [
              // NavigationRailDestination(
              //   icon: Icon(Icons.dashboard, color: Colors.white,),
              //   selectedIcon: Icon(Icons.dashboard, color: Colors.white,),
              //   label: Text("Dashboard", style: TextStyle(color: Colors.white))
              // ),
              // NavigationRailDestination(
              //   icon: Icon(Icons.list, color: Colors.white,),
              //   selectedIcon: Icon(Icons.list, color: Colors.white,),
              //   label: Text("Details", style: TextStyle(color: Colors.white))
              // ),
              // NavigationRailDestination(
              //   icon: Icon(Icons.info_outline, color: Colors.white,),
              //   selectedIcon: Icon(Icons.info, color: Colors.white,),
              //   label: Text("About", style: TextStyle(color: Colors.white))
              // ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.view_list,
                ),
                label: Text(
                  "Pregled čitaonica",
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_box_outlined),
                label: Text(
                  "Dodavanje čitaonice",
                ),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text(
                  "Promjena lozinke",
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout_outlined),
                label: Text(
                  "Odjava",
                ),
              )
            ],
          ),
          Expanded(
              child: IndexedStack(index: _selectedIndex, children: screens)),
        ],
      ),
    );
  }
}

class Dodavanje extends StatefulWidget {
  const Dodavanje({Key? key}) : super(key: key);

  @override
  _DodavanjeState createState() => _DodavanjeState();
}

class _DodavanjeState extends State<Dodavanje> {
  @override
  Widget build(BuildContext context) {
    return const DodavanjeCitaoniceWrapperPage();
  }
}

class Pregled extends StatefulWidget {
  const Pregled({Key? key}) : super(key: key);

  @override
  _PregledState createState() => _PregledState();
}

class _PregledState extends State<Pregled> {
  @override
  Widget build(BuildContext context) {
    return const PregledCitaonicaWrapperPage();
  }
}

class Lozinka extends StatefulWidget {
  const Lozinka({Key? key}) : super(key: key);

  @override
  _LozinkaState createState() => _LozinkaState();
}

class _LozinkaState extends State<Lozinka> {
  @override
  Widget build(BuildContext context) {
    return const PromjenaLozinkeWrapperPage();
  }
}

class Odjava extends StatefulWidget {
  const Odjava({Key? key}) : super(key: key);

  @override
  _OdjavaState createState() => _OdjavaState();
}

class _OdjavaState extends State<Odjava> {
  @override
  Widget build(BuildContext context) {
    return const OdjavaWrapperPage();
  }
}
