import 'package:dio/dio.dart';
import 'package:web_aplikacija/models/individualna_sala.dart';

class IndividualneSaleService {
  final Dio _dio = Dio();

  final _baseUrl = 'http://localhost:3000';

  Future<List<IndividualnaSala>> getIndividualneSale(String citaonicaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response saleData = await _dio.get(
          _baseUrl + '/citaonice/${citaonicaId.toString()}/individualne_sale');

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
        _baseUrl + '/citaonice/${citaonicaId}/individualne_sale',
        data: sala.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedIndividualnaSala = IndividualnaSala.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedIndividualnaSala;
  }

  Future<void> deleteIndividualnaSala(
      {required String citaonicaId, required String individualnaSalaId}) async {
    try {
      await _dio.delete(
        _baseUrl +
            '/citaonice/$citaonicaId/individualne_sale/$individualnaSalaId',
      );
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<IndividualnaSala?> azurirajIndividualnuSalu(
      {required IndividualnaSala individualnaSalaData,
      required String citaonicaId}) async {
    IndividualnaSala? retrievedIndividualnaSala;

    try {
      Response response = await _dio.put(
        _baseUrl +
            '/citaonice/${citaonicaId}/individualne_sale/${individualnaSalaData.id}',
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
