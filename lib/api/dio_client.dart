import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio dio = Dio(BaseOptions(
    baseUrl: "http://localhost:8080/api/v1",
  ));
  Dio tokenDio = Dio(BaseOptions(baseUrl: "http://localhost:8080/api/v1"));

  DioClient() {
    dio.interceptors
      ..add(LogInterceptor(responseBody: false))
      ..add(QueuedInterceptorsWrapper(
        onError: (error, hendler) async {
          if (error.response?.statusCode == 403 ||
              error.response?.statusCode == 401) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var options = error.response!.requestOptions;
            if (prefs.getString('accessToken') !=
                options.headers['Authorization'].toString().split(' ')[1]) {
              options.headers['Authorization'] =
                  'Bearer ${prefs.getString('accessToken')}';
              var odgovor1 = await _retry(options);
              hendler.resolve(odgovor1);
              return;
            }
            await refreshToken();
            final odgovor2 = await _retry(options);
            hendler.resolve(odgovor2);
            return;
          }
          hendler.next(error);
        },
        onRequest: (options, hendler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          options.headers['Authorization'] =
              'Bearer ${prefs.getString('accessToken')}';

          hendler.next(options);
        },
      ));
  }

  Future<void> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    final response =
        await dio.post('/refreshtoken', data: {'refreshToken': refreshToken});
    if (response.statusCode == 201) {
      prefs.setString('accessToken', response.data['accessToken']);
      prefs.setString('refreshToken', response.data['refreshToken']);
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
