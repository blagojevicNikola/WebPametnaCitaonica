import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/web_login.dart';
import 'package:web_aplikacija/supervizor/supervizor_models/obavjestenje.dart';

class OdjavaService {
  Future<WebLogin?> createOdjava({
    required DioClient dioClient,
  }) async {
    WebLogin? retrievedObavjestenje;

    try {
      Response response = await dioClient.dio.post('/odjava/');

      //print('User created: ${response.data}');

      retrievedObavjestenje = WebLogin.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedObavjestenje;
  }
}
