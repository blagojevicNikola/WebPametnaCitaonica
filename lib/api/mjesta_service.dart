import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/mjesto.dart';

class MjestaService {
  Future<List<Mjesto>> getMjesta(
      DioClient dioClient, String individualnaSalaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response citaoniceData = await dioClient.dio
          .get('/individualne-sale/$individualnaSalaId/mjesta/');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<Mjesto> citaonice = (citaoniceData.data as List)
          .map((data) => Mjesto.fromJson(data))
          .toList();

      return citaonice;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Mjesto?> createMjesta(
      {required DioClient dioClient,
      required String individualnaSalaId,
      required Mjesto mjestoInfo}) async {
    Mjesto? retrievedMjesto;

    try {
      Response response = await dioClient.dio.post(
          '/individualne-sale/$individualnaSalaId/mjesta/',
          data: mjestoInfo.toJson());

      //print('User created: ${response.data}');

      retrievedMjesto = Mjesto.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedMjesto;
  }

  Future<Response?> deleteMjesto(
      {required DioClient dioClient,
      required String individualnaSalaId,
      required String mjestaId}) async {
    try {
      Response? temp = await dioClient.dio.delete(
        '/individualne-sale/$individualnaSalaId/mjesta/$mjestaId',
      );
      return temp;
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<Response?> azurirajMjesta(
      {required DioClient dioClient,
      required Mjesto mjestoInfo,
      required String individualnaSalaId,
      required String mjestoId}) async {
    Response? temp;
    try {
      Response response = await dioClient.dio.put(
        '/individualne-sale/$individualnaSalaId/mjesta/$mjestoId',
        data: mjestoInfo.toJson(),
      );
      temp = response;
    } catch (e) {
      print('Error creating user: $e');
    }
    return temp;
    //print('User created: ${response.data}');
  }

  Future<Response?> zakljucajMjesto(
      {required DioClient dioClient,
      required bool dostupno,
      required String individualnaSalaId,
      required String mjestoId}) async {
    try {
      Response? temp = await dioClient.dio
          .patch('/mjesta/$mjestoId/dostupnost/', data: {'dostupno': dostupno});
      return temp;
    } catch (err) {
      rethrow;
    }
  }
}
