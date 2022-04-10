import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/mjesto.dart';

class MjestaService {
  Future<List<Mjesto>> getMjesta(
      DioClient dioClient, String individualnaSalaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response citaoniceData = await dioClient.dio
          .get('/individualne-sale/$individualnaSalaId/mjesta');

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
          '/individualne-sale/$individualnaSalaId/mjesta',
          data: mjestoInfo.toJson());

      //print('User created: ${response.data}');

      retrievedMjesto = Mjesto.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedMjesto;
  }

  Future<Response?> deleteCitaonica(
      {required DioClient dioClient, required String citaonicaId}) async {
    Response? temp;
    try {
      temp = await dioClient.dio.delete(
        '/citaonice/$citaonicaId',
      );
    } catch (e) {
      print('Error deleting user: $e');
    }
    return temp;
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
}