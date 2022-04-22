import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/citaonica.dart';
import 'package:web_aplikacija/supervizor/supervizor_home_page.dart';

class CitaonicaService {
  Future<List<Citaonica>> getCitaonice(DioClient dioClient) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response citaoniceData = await dioClient.dio.get('/citaonice');

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

  Future<Citaonica> getJednaCitaonica(
      DioClient dioClient, String superivozrId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response citaoniceData =
          await dioClient.dio.get('/supervizori/$supervizorskiId/citaonica');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      Citaonica citaonice = Citaonica.fromJson(citaoniceData.data);
      return citaonice;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Citaonica?> createCitaonica(
      {required DioClient dioClient, required Citaonica citaonicaInfo}) async {
    Citaonica? retrievedCitaonica;

    try {
      Response response = await dioClient.dio.post(
        '/citaonice/',
        data: citaonicaInfo.toJson(),
      );

      //print('User created: ${response.data}');

      retrievedCitaonica = Citaonica.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedCitaonica;
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

  Future<Response?> postaviSliku(
      {required DioClient dioClient,
      required String url,
      required String citaonicaId}) async {
    Response? temp;
    try {
      temp = await dioClient.dio.post(
        url,
      );
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<Response?> azurirajCitaonicu(
      {required DioClient dioClient,
      required Citaonica citaonicaInfo,
      required String index}) async {
    try {
      Response? temp = await dioClient.dio.put(
        '/citaonice/$index',
        data: citaonicaInfo.toJson(),
      );
      return temp;
    } on DioError catch (err) {
      rethrow;
    } catch (err) {
      throw Exception('Greska pri azuriranju citaonice!');
    }
    //print('User created: ${response.data}');
  }
}
