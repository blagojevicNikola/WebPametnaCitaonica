import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_aplikacija/api/dio_client.dart';

import '../models/web_login.dart';

class AuthService {
  Future<Response?> postLogin(
      DioClient dioClient, String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? temp;
    try {
      temp = await dioClient.dio.post('/prijava',
          data: {"korisnickoIme": username, "lozinka": password});

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');
      if (temp.statusCode == 201) {
        WebLogin korisnik = WebLogin.fromJson(temp.data);
        prefs.setString('accessToken', korisnik.accessToken);
        prefs.setString('refreshToken', korisnik.refreshToken);
      }
      // Parsing the raw JSON data to the User class
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
    return temp;
  }
}
