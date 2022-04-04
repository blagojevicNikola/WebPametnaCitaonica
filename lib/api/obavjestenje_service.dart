import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/supervizor/supervizor_models/obavjestenje.dart';

class ObavjestenjeService {
  final DioClient _dioClient = DioClient();

  final _baseUrl = 'http://localhost:8080/api/v1';

  Future<List<Obavjestenje>> getObavjestenja(
      String citaonicaId, String supervizorId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response obavjestenjaData = await _dioClient.dio.get(_baseUrl +
          '/citaonice/' +
          '${citaonicaId.toString()}/' +
          // '${supervizorId.toString()}/' +
          'obavjestenja');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<Obavjestenje> obavjestenja = (obavjestenjaData.data as List)
          .map((data) => Obavjestenje.fromJson(data))
          .toList();

      return obavjestenja;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Obavjestenje?> createObavjestenje(
      {required Obavjestenje obavjestenjeInfo,
      required String citaonicaId,
      required String supervizorId}) async {
    Obavjestenje? retrievedObavjestenje;

    try {
      Response response = await _dioClient.dio.post(
        _baseUrl +
            '/supervizori/' +
            '${supervizorId.toString()}/' +
            // '${supervizorId.toString()}/' +
            'obavjestenja',
        data: obavjestenjeInfo.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedObavjestenje = Obavjestenje.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedObavjestenje;
  }

  Future<void> deleteObavjestenje(
      {required String obavjestenjeId, required String citaonicaId}) async {
    try {
      await _dioClient.dio.delete(_baseUrl +
          // '/citaonice/' +
          // '${citaonicaId.toString()}/' +
          '/obavjestenja/' +
          '${obavjestenjeId.toString()}/');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  /* Future<Obavjestenje?> azurirajCitaonicu(
      {required Obavjestenje ObavjestenjeInfo, required String citaonicaId}) async {
    Obavjestenje? retrievedCitaonica;

    try {
      Response response = await _dio.put(
        _baseUrl + '/citaonice/${citaonicaId.toString()}/'+'obavjestenja',
        data: citaonicaInfo.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedCitaonica = Citaonica.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedCitaonica;
  }*/
}
