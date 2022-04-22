import 'package:flutter/material.dart';

import '../models/citaonica.dart';

class CitaonicaCard extends StatelessWidget {
  final Citaonica citaonicaData;
  const CitaonicaCard(this.citaonicaData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 3,
        borderOnForeground: false,
        borderRadius: BorderRadius.circular(21),
        child: InkWell(
          borderRadius: BorderRadius.circular(21),
          //hoverColor: Colors.transparent,
          onTap: () => {
            Navigator.of(context)
                .pushNamed('pregled/citaonica', arguments: citaonicaData)
          },
          child: Ink(
            //height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
              color: const Color.fromARGB(255, 254, 255, 255),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     offset: const Offset(0, 3),
              //     blurRadius: 7,
              //   ),
              // ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 9, 3),
                      child: Text(
                        citaonicaData.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 177, 211, 240),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 3),
                      child:
                          Icon(Icons.lock_open, color: Colors.green, size: 30),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 9, 9, 3),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Adresa:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 105, 105, 105),
                                  ),
                                ),
                                TextSpan(
                                  text: citaonicaData.adresa,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 105, 105, 105),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 9, 9, 3),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'E-mail:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 105, 105, 105),
                                  ),
                                ),
                                TextSpan(
                                  text: citaonicaData.mail,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 105, 105, 105),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 9, 9, 3),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Telefon:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 105, 105, 105),
                                  ),
                                ),
                                TextSpan(
                                  text: citaonicaData.phoneNumber,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 105, 105, 105),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 9, 9, 3),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Radno vrijeme:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 105, 105, 105),
                                  ),
                                ),
                                // TextSpan(
                                //   text: citaonicaData.radnoVrijeme,
                                //   style: const TextStyle(
                                //     fontSize: 18,
                                //     fontWeight: FontWeight.normal,
                                //     color: Color.fromARGB(255, 105, 105, 105),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 9, 15, 15),
                      child: Container(
                        height:
                            (MediaQuery.of(context).size.height * 0.25) * 0.6,
                        width:
                            (MediaQuery.of(context).size.width * 0.55) * 0.27,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            //bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(21.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'http://pametna-citaonica.azurewebsites.net/api/v1/citaonice/${citaonicaData.id}/slika'),
                              fit: BoxFit.fill),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
