import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OdjavaPage extends StatefulWidget {
  const OdjavaPage({Key? key}) : super(key: key);

  @override
  _OdjavaPageState createState() => _OdjavaPageState();
}

class _OdjavaPageState extends State<OdjavaPage> {
  //late Future<Korisnik> test;

  @override
  Widget build(BuildContext context) {
    //double visina = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.8,
        color: const Color.fromARGB(255, 132, 186, 230),
        child: InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Odjava'),
                  content: const Text(
                      'Da li ste sigurni da se želite odjaviti?',
                      style: TextStyle(fontSize: 20)),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Odjava'),
                            content: const Text('Uspješno ste se odjavili !'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove('email');
                                  final pref =
                                      await SharedPreferences.getInstance();
                                  await pref.clear();
                                  //Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
                                  Navigator.popUntil(
                                      context, ModalRoute.withName("/"));
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
            },
            child: const Text('Odjava')),
      ),
    );
  }
}
