import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/supervizor/supervizor_models/obavjestenje.dart';

class ObavjestenjeService {
  Future<List<Obavjestenje>> getObavjestenja(
      DioClient dioClient, int citaonicaId, int supervizorId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      print('citaonicaid $citaonicaId');
      print('supervizorid $supervizorId');
      Response obavjestenjaData = await dioClient.dio
          .get('/citaonice/${citaonicaId.toString()}/obavjestenja');
      // '${supervizorId.toString()}/' +

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
      {required DioClient dioClient,
      required Obavjestenje obavjestenjeInfo,
      required int citaonicaId,
      required int supervizorId}) async {
    Obavjestenje? retrievedObavjestenje;

    try {
      Response response = await dioClient.dio.post(
        '/citaonice/'
        '${citaonicaId.toString()}/'
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
      {required DioClient dioClient,
      required int obavjestenjeId,
      required int citaonicaId}) async {
    try {
      await dioClient.dio.delete('/citaonice/'
              '${citaonicaId.toString()}/' +
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
