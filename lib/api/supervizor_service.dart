import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/mjesto.dart';
import 'package:web_aplikacija/models/nalog.dart';

class SupervizorService {
  Future<List<Nalog>> getSupervizore(
      DioClient dioClient, String citaonicaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response supervizoriData =
          await dioClient.dio.get('/citaonice/$citaonicaId/supervizori/');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<Nalog> supervizori = (supervizoriData.data as List)
          .map((data) => Nalog.fromJson(data))
          .toList();

      return supervizori;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Nalog?> createSupervizor(
      {required DioClient dioClient,
      required String citaonicaId,
      required Nalog supervizorInfo}) async {
    Nalog? retrievedMjesto;

    try {
      Response response = await dioClient.dio.post(
          '/citaonice/$citaonicaId/supervizori/',
          data: supervizorInfo.toJson());

      //print('User created: ${response.data}');

      retrievedMjesto = Nalog.fromJson(response.data);
    } catch (e) {
      rethrow;
    }

    return retrievedMjesto;
  }

  Future<Response?> deleteSupervizor(
      {required DioClient dioClient,
      required String citaonicaId,
      required String supervizorId,
      required String supervizorPassword}) async {
    Response? temp;
    try {
      temp = await dioClient.dio.delete(
          '/citaonice/$citaonicaId/supervizori/$supervizorId',
          data: {'lozinka': supervizorPassword});
    } catch (e) {
      print('Error deleting user: $e');
    }
    return temp;
  }

  Future<Response?> azurirajSupervizor(
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

  Future<Response?> zakljucajSupervizora(
      {required DioClient dioClient,
      required bool zakljucaj,
      required String nalogId}) async {
    try {
      Response? temp;
      if (!zakljucaj) {
        temp = await dioClient.dio
            .patch('/nalozi/$nalogId/lock/', data: {'status': 'otkljucano'});
      } else {
        temp = await dioClient.dio
            .patch('/nalozi/$nalogId/lock/', data: {'status': 'zakljucano'});
      }
      return temp;
    } catch (err) {
      rethrow;
    }
  }
}
