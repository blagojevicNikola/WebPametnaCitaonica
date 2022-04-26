import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/grupne_rezervacije_mjesta_prikaz.dart';

class PrikazGrupnihRezervacijaSaleService {
  Future<List<GrupneRezervacijeSalePrikaz>> getGrupRezSale(DateTime vrijemeOd,
      DateTime vrijemeDo, DioClient dioClient, int salaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      print('$salaId');
      Response grupRezSaleData = await dioClient.dio.post(
          '/grupne-sale/${salaId.toString()}/rezervacije-vrijeme/',
          data: {
            'vrijemeVazenjaOd': vrijemeOd.toString(),
            'vrijemeVazenjaDo': vrijemeDo.toString()
          });
      // '${supervizorId.toString()}/' +

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<GrupneRezervacijeSalePrikaz> grupneRezervacije =
          (grupRezSaleData.data as List)
              .map((data) => GrupneRezervacijeSalePrikaz.fromJson(data))
              .toList();

      return grupneRezervacije;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Response> deleteRezervacija(
      {required DioClient dioClient,
      required int salaId,
      required int rezervacijaId}) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response odgovor = await dioClient.dio.delete(
        '/grupne-sale/${salaId.toString()}/rezervacije/${rezervacijaId.toString()}',
      );

      return odgovor;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
