import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';

import '../models/grupna_sala.dart';

class GrupneSaleService {
  Future<List<GrupnaSala>> getGrupneSale(
      DioClient dioClient, String citaonicaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response saleData = await dioClient.dio
          .get('/citaonice/${citaonicaId.toString()}/grupne-sale/');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<GrupnaSala> grupneSale = (saleData.data as List)
          .map((data) => GrupnaSala.fromJson(data))
          .toList();

      return grupneSale;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Response?> createGrupnaSala(
      {required DioClient dioClient,
      required String citaonicaId,
      required GrupnaSala sala}) async {
    Response? temp;

    try {
      Response response = await dioClient.dio.post(
        '/citaonice/$citaonicaId/grupne-sale/',
        data: sala.toJson(),
      );

      //print('User created: ${response.data}');

      temp = response;
    } catch (e) {
      rethrow;
    }

    return temp;
  }

  Future<String> deleteGrupnaSala(
      {required DioClient dioClient,
      required String citaonicaId,
      required String grupnaSalaId}) async {
    Response response = await dioClient.dio.delete(
      '/citaonice/$citaonicaId/grupne-sale/$grupnaSalaId',
    );

    if (response.statusCode == 204) {
      return response.data;
    } else {
      throw Exception('Greska pri brisanju');
    }
  }

  Future<Response?> azurirajGrupnuSalu(
      {required DioClient dioClient,
      required GrupnaSala grupnaSalaData,
      required String citaonicaId}) async {
    Response? temp;

    try {
      temp = await dioClient.dio.put(
        '/citaonice/${citaonicaId}/grupne-sale/${grupnaSalaData.id}',
        data: grupnaSalaData.toJson(),
      );

      //print('User created: ${response.data}');

    } catch (e) {
      print('Error creating user: $e');
    }

    return temp;
  }

  Future<Response?> zakljucajGrupnuSalu(
      {required DioClient dioClient,
      required bool dostupno,
      required String citaonicaId,
      required String grupnaSalaId}) async {
    try {
      Response? temp;
      temp = await dioClient.dio.patch('/grupne-sale/$grupnaSalaId/dostupnost/',
          data: {'dostupno': dostupno});

      return temp;
    } catch (err) {
      rethrow;
    }
  }
}
