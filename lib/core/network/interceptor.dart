import 'package:dio/dio.dart';

import '../utils/logging.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    printLog(message: '${options.method} request ==> $requestPath'); //Error log
    printLog(
        message: 'Error type: ${err.error} \n '
            'Error message: ${err.message}'); //Debug log
    handler.next(err); //Continue with the Error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    printLog(message: '${options.method} request ==> $requestPath'); //Info log
    handler.next(options); // continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printLog(
        message: 'STATUSCODE: ${response.statusCode} \n '
            'STATUSMESSAGE: ${response.statusMessage} \n'
            'HEADERS: ${response.headers} \n'
            'Data: ${response.data}'); // Debug log
    handler.next(response); // continue with the Response
  }
}

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // final token = sharedPreferences.getString('token');
    // options.headers['Authorization'] = "Bearer $token";
    handler.next(options); // continue with the Request
  }
}
