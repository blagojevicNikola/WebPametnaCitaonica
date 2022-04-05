import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';
import 'package:web_aplikacija/models/mjesto.dart';
import 'package:web_aplikacija/models/nalog.dart';
import 'package:web_aplikacija/widgets/karakteristike_field.dart';

class KarakteristikeSaleService {
  Future<List<KarakteristikeSale>> getkarakteristike(
      DioClient dioClient) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response karakteristikeData = await dioClient.dio.get('/karakteristike');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<KarakteristikeSale> karakteristike =
          (karakteristikeData.data as List)
              .map((data) => KarakteristikeSale.fromJson(data))
              .toList();

      return karakteristike;
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
          '/citaonice/$citaonicaId/supervizori',
          data: supervizorInfo.toJson());

      //print('User created: ${response.data}');

      retrievedMjesto = Nalog.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedMjesto;
  }

  Future<Response?> deleteSupervizor(
      {required DioClient dioClient,
      required String citaonicaId,
      required String supervizorId}) async {
    Response? temp;
    try {
      temp = await dioClient.dio.delete(
        '/citaonice/$citaonicaId/supervizori/$supervizorId',
      );
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
}
