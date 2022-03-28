import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'package:web_aplikacija/supervizor/pages/promjena_informacija_citaonice.dart';

import 'package:web_aplikacija/wrappers/supervizorski_pregled_sale_wrapper.dart';
=======
import 'package:web_aplikacija/pages/odjava_page.dart';
import 'package:web_aplikacija/pages/pregled_citaonica_page.dart';
import 'package:web_aplikacija/pages/promjena_lozinke_page.dart';
import 'package:web_aplikacija/supervizor/pages/pregled_sala_page_prazan.dart';
import 'package:web_aplikacija/supervizor/pages/promjena_informacija_prazan.dart';
import 'package:web_aplikacija/supervizor/pages/slanje_notifikacija.dart';
//import 'package:web_aplikacija/supervizor/pages/promjena_informacija_prazan.dart';
>>>>>>> milos

class SupervizorHomePage extends StatefulWidget {
  const SupervizorHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SupervizorHomePage> createState() => _SupervizorHomePageState();
}

class _SupervizorHomePageState extends State<SupervizorHomePage> {
  int _selectedIndex = 0;
  List<Widget> screens = [
<<<<<<< HEAD
    const SupervizorskiPregledSaleWrapper(),
    SlanjeNotifikacijaPage(),
    PromjenaInformacijaCitaonice(),
    SupervizorskaPromjenaLozinkePage(),
    SupervizorskaOdjavaPage(),
=======
    const PregledSalaPageTest(),
    const SlanjeNotifikacija(),
    const PromjenaInformacijaPrazan(),
    const PromjenaLozinkePage(),
    const OdjavaPage()
    // const Lozinka(),
    // const Odjava()
>>>>>>> milos
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
                  child: Text('Supervizor',
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
                  "Pregled sala",
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.message),
                label: Text(
                  "Slanje notifikacija",
                ),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.info),
                label: Text(
                  "Promjena informacija",
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

class SlanjeNotifikacijaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

class SupervizorskaPromjenaLozinkePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

class SupervizorskaOdjavaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
