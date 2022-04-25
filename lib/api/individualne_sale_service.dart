import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/individualna_sala.dart';

class IndividualneSaleService {
  Future<List<IndividualnaSala>> getIndividualneSale(
      DioClient dioClient, String citaonicaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response saleData = await dioClient.dio
          .get('/citaonice/${citaonicaId.toString()}/individualne-sale/');

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
      {required DioClient dioClient,
      required String citaonicaId,
      required IndividualnaSala sala}) async {
    IndividualnaSala? retrievedIndividualnaSala;

    try {
      Response response = await dioClient.dio.post(
        '/citaonice/${citaonicaId}/individualne-sale',
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
      {required DioClient dioClient,
      required String citaonicaId,
      required String individualnaSalaId}) async {
    Response response = await dioClient.dio.delete(
      '/citaonice/$citaonicaId/individualne-sale/$individualnaSalaId',
    );

    if (response.statusCode == 204) {
      return response.data;
    } else {
      throw Exception('Greska pri brisanju');
    }
  }

  Future<IndividualnaSala?> azurirajIndividualnuSalu(
      {required DioClient dioClient,
      required IndividualnaSala individualnaSalaData,
      required String citaonicaId,
      required String individualnaSalaId}) async {
    IndividualnaSala? retrievedIndividualnaSala;

    try {
      Response response = await dioClient.dio.put(
        '/citaonice/$citaonicaId/individualne-sale/$individualnaSalaId',
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
