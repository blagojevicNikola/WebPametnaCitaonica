import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio dio = Dio(BaseOptions(baseUrl: "http://localhost:8080/api/v1"));

  DioClient() {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, hendler) async {
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 401) {
          await refreshToken();
          return hendler.resolve(await _retry(error.requestOptions));
        }
        return hendler.next(error);
      },
      onRequest: (options, hendler) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        options.headers['Authorization'] =
            'Bearer: ${prefs.getString('accessToken')}';
        return hendler.next(options);
      },
    ));
  }

  Future<void> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    final response =
        await dio.post('/users/refresh', data: {'token': refreshToken});
    if (response.statusCode == 200) {
      prefs.setString('accessToken', response.data['accessToken']);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<void>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
