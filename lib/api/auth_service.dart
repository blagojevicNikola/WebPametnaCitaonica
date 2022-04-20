import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_aplikacija/api/dio_client.dart';

import '../models/web_login.dart';

class AuthService {
  Future<Response?> postLogin(
      DioClient dioClient, String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response? temp = await dioClient.dio.post('/prijava',
          data: {"korisnickoIme": username, "lozinka": password});

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');
      if (temp.statusCode == 201) {
        WebLogin korisnik = WebLogin.fromJson(temp.data);
        prefs.setString('accessToken', korisnik.accessToken);
        prefs.setString('refreshToken', korisnik.refreshToken);
        return temp;
      }
      // Parsing the raw JSON data to the User class
    } on DioError catch (error) {
      rethrow;
    } catch (err, stacktrace) {
      throw Exception("Exception occured: $err stackTrace: $stacktrace");
    }
  }
}
