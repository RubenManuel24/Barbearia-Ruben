import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'interceptors/auth_interceptor.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(BaseOptions(
            baseUrl: 'http://192.168.0.195:8080',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60))) {
    interceptors
        .addAll([
          LogInterceptor(responseBody: true, requestBody: true),
          AuthInterceptor()

        ]);
  }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unAuth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}
