import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/argumenti_prikaza_individualne_rezervacije_mjesta.dart';
import 'package:web_aplikacija/models/individualne_rezervacije_mjesta_prikaz.dart';

class PrikazIndividualnihRezervacijaMjestaService {
  Future<List<IndividualneRezervacijeMjestaPrikaz>> getIndRezMjesta(
      DateTime vrijemeOd,
      DateTime vrijemeDo,
      DioClient dioClient,
      int mjestoId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response indRezMjestaData = await dioClient.dio
          .post('/mjesta/${mjestoId.toString()}/rezervacije-vrijeme/', data: {
        'vrijemeVazenjaOd': vrijemeOd.toString(),
        'vrijemeVazenjaDo': vrijemeDo.toString()
      });
      // '${supervizorId.toString()}/' +

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<IndividualneRezervacijeMjestaPrikaz> indRezervacije =
          (indRezMjestaData.data as List)
              .map((data) => IndividualneRezervacijeMjestaPrikaz.fromJson(data))
              .toList();

      return indRezervacije;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Response> deleteRezervacija(
      {required DioClient dioClient,
      required int mjestoId,
      required int rezervacijaId}) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response odgovor = await dioClient.dio.delete(
        '/mjesta/${mjestoId.toString()}/rezervacije/${rezervacijaId.toString()}',
      );

      return odgovor;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
