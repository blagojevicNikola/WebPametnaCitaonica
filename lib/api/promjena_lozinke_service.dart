import 'package:dio/dio.dart';
import 'package:web_aplikacija/api/dio_client.dart';
import 'package:web_aplikacija/models/promjena_lozinke.dart';

class PromjenaLozinkeService {
  Future<Response?> promjeniLozinku(
      {required DioClient dioClient,
      required PromjenaLozinke promjenaLozinkeData}) async {
    // WebLogin? retrievedObavjestenje;
    Response? response;

    try {
      response = await dioClient.dio
          .patch('/promjena-lozinke/', data: promjenaLozinkeData.toJson());

      //print('User created: ${response.data}');

      //retrievedObavjestenje = WebLogin.fromJson(response.data);
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
