import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:web_aplikacija/models/citaonica.dart';

class CitaonicaService {
  final Dio _dio = Dio();

  final _baseUrl = 'http://localhost:8080/api/v1';

  Future<List<Citaonica>> getCitaonice() async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response citaoniceData = await _dio.get(_baseUrl + '/citaonice');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<Citaonica> citaonice = (citaoniceData.data as List)
          .map((data) => Citaonica.fromJson(data))
          .toList();

      return citaonice;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Citaonica?> createCitaonica({required Citaonica citaonicaInfo}) async {
    Citaonica? retrievedCitaonica;

    try {
      Response response = await _dio.post(
        _baseUrl + '/citaonice/',
        data: citaonicaInfo.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedCitaonica = Citaonica.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedCitaonica;
  }

  Future<void> deleteCitaonica({required String citaonicaId}) async {
    try {
      await _dio.delete(
        _baseUrl + '/citaonice/$citaonicaId',
      );
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<Citaonica?> azurirajCitaonicu(
      {required Citaonica citaonicaInfo}) async {
    Citaonica? retrievedCitaonica;

    try {
      Response response = await _dio.put(
        _baseUrl + '/citaonice/${citaonicaInfo.id}',
        data: citaonicaInfo.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedCitaonica = Citaonica.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedCitaonica;
  }
}
