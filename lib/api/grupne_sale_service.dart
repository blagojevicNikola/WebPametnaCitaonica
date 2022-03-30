import 'package:dio/dio.dart';

import '../models/grupna_sala.dart';

class GrupneSaleService {
  final Dio _dio = Dio();

  final _baseUrl = 'http://localhost:8080/api/v1';

  Future<List<GrupnaSala>> getGrupneSale(String citaonicaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response saleData = await _dio
          .get(_baseUrl + '/citaonice/${citaonicaId.toString()}/grupne-sale');

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

  Future<GrupnaSala?> createGrupnaSala(
      {required String citaonicaId, required GrupnaSala sala}) async {
    GrupnaSala? retrievedGrupnaSala;

    try {
      Response response = await _dio.post(
        _baseUrl + '/citaonice/${citaonicaId}/grupne-sale',
        data: sala.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedGrupnaSala = GrupnaSala.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedGrupnaSala;
  }

  Future<String> deleteGrupnaSala(
      {required String citaonicaId, required String grupnaSalaId}) async {
    Response response = await _dio.delete(
      _baseUrl + '/citaonice/$citaonicaId/grupne-sale/$grupnaSalaId',
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Greska pri brisanju');
    }
  }

  Future<GrupnaSala?> azurirajGrupnuSalu(
      {required GrupnaSala grupnaSalaData, required String citaonicaId}) async {
    GrupnaSala? retrievedGrupnaSala;

    try {
      Response response = await _dio.put(
        _baseUrl +
            '/citaonice/${citaonicaId}/individualne-sale/${grupnaSalaData.id}',
        data: grupnaSalaData.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedGrupnaSala = GrupnaSala.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedGrupnaSala;
  }
}
