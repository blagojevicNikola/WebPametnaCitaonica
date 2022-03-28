import 'package:flutter/material.dart';

import '../constants/config.dart';

class SupervizorskiIndTile extends StatelessWidget {
  const SupervizorskiIndTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
        ),
        width: double.infinity,
        height: 60,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Sala 1',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 105, 105, 105),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                      child: Text(
                        '3',
                        style: TextStyle(
                          fontSize: 24,
                          color: defaultKarakteristike,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 9, 0),
                      child: Icon(
                        Icons.person,
                        size: 24,
                        color: defaultKarakteristike,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                      child: Material(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.transparent,
                        child: IconButton(
                          color: const Color.fromARGB(255, 105, 105, 105),
                          splashRadius: 25,
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                      child: Material(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.transparent,
                        child: IconButton(
                          hoverColor: const Color.fromARGB(255, 224, 110, 102),
                          splashColor: const Color.fromARGB(255, 235, 61, 48),
                          color: const Color.fromARGB(255, 105, 105, 105),
                          splashRadius: 25,
                          icon: const Icon(Icons.lock),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
