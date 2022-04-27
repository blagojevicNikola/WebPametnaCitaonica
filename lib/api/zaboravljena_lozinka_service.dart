import 'package:dio/dio.dart';
import 'package:web_aplikacija/models/reset_lozinke.dart';
import 'package:web_aplikacija/models/zaboravljena_lozinka_email.dart';
import 'dio_client.dart';

class ZaboravljenaLozinkaService {
  Future<Response?> slanjeEmaila(
      {required DioClient dioClient,
      required ZaboravljenaLozinkaEmail emailData}) async {
    Response? response;

    try {
      response = await dioClient.dio.post(
        '/zaboravljena-lozinka/',
        data: emailData.toJson(),
      );
    } catch (e) {
      rethrow;
    }

    return response;
  }

  Future<Response?> resetujLozinku(
      {required DioClient dioClient, required ResetLozinke resetData}) async {
    Response? response;

    try {
      response = await dioClient.dio.post(
        '/zaboravljena-lozinka-promjena/',
        data: resetData.toJson(),
      );
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
