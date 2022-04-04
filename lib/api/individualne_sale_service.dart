import 'package:dio/dio.dart';
import 'package:web_aplikacija/models/individualna_sala.dart';

class IndividualneSaleService {
  final Dio _dio = Dio();

  final _baseUrl = 'http://localhost:8080/api/v1';

  Future<List<IndividualnaSala>> getIndividualneSale(String citaonicaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response saleData = await _dio.get(
          _baseUrl + '/citaonice/${citaonicaId.toString()}/individualne-sale');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<IndividualnaSala> individualneSale = (saleData.data as List)
          .map((data) => IndividualnaSala.fromJson(data))
          .toList();

      return individualneSale;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<IndividualnaSala?> createIndividualnaSala(
      {required String citaonicaId, required IndividualnaSala sala}) async {
    IndividualnaSala? retrievedIndividualnaSala;

    try {
      Response response = await _dio.post(
        _baseUrl + '/citaonice/${citaonicaId}/individualne-sale',
        data: sala.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedIndividualnaSala = IndividualnaSala.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedIndividualnaSala;
  }

  Future<String> deleteIndividualnaSala(
      {required String citaonicaId, required String individualnaSalaId}) async {
    Response response = await _dio.delete(
      _baseUrl +
          '/citaonice/$citaonicaId/individualne-sale/$individualnaSalaId',
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Greska pri brisanju');
    }
  }

  Future<IndividualnaSala?> azurirajIndividualnuSalu(
      {required IndividualnaSala individualnaSalaData,
      required String citaonicaId}) async {
    IndividualnaSala? retrievedIndividualnaSala;

    try {
      Response response = await _dio.put(
        _baseUrl +
            '/citaonice/$citaonicaId/individualne-sale/${individualnaSalaData.id}',
        data: individualnaSalaData.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedIndividualnaSala = IndividualnaSala.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedIndividualnaSala;
  }
}
