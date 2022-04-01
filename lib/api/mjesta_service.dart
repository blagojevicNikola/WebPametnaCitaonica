import 'package:dio/dio.dart';
import 'package:web_aplikacija/models/mjesto.dart';

class MjestaService {
  final Dio _dio = Dio();

  final _baseUrl = 'http://localhost:8080/api/v1';

  Future<List<Mjesto>> getMjesta(String individualnaSalaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response citaoniceData = await _dio
          .get(_baseUrl + '/individualne-sale/$individualnaSalaId/mjesta');

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
      {required String individualnaSalaId, required Mjesto mjestoInfo}) async {
    Mjesto? retrievedMjesto;

    try {
      Response response = await _dio.post(
          _baseUrl + '/individualne-sale/$individualnaSalaId/mjesta',
          data: mjestoInfo.toJson());

      //print('User created: ${response.data}');

      retrievedMjesto = Mjesto.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedMjesto;
  }

  Future<Response?> deleteCitaonica({required String citaonicaId}) async {
    Response? temp;
    try {
      temp = await _dio.delete(
        _baseUrl + '/citaonice/$citaonicaId',
      );
    } catch (e) {
      print('Error deleting user: $e');
    }
    return temp;
  }

  Future<Response?> azurirajCitaonicu(
      {required Mjesto citaonicaInfo, required String index}) async {
    Response? temp;
    try {
      Response response = await _dio.put(
        _baseUrl + '/citaonice/${citaonicaInfo.id}',
        data: citaonicaInfo.toJson(),
      );
      temp = response;
    } catch (e) {
      print('Error creating user: $e');
    }
    return temp;
    //print('User created: ${response.data}');
  }
}
