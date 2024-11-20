import 'dart:io';
import 'package:barbearia_rb/src/core/ui/barbershop_nav_globa_key.dart';
import 'package:flutter/material.dart';
import 'package:barbearia_rb/src/core/constants/local_storage_keys.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();

      headers.addAll(
          {authHeaderKey: 'Bearer ${sp.getString(LocalStorageKeys.accessToken)}'});
    }
    handler.next(options);
  }


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;

    if (extra case {'DIO_AUTH_KEY': true}) {
      if(response != null && response.statusCode == HttpStatus.forbidden){
  
       Navigator.of(BarbershopNavGlobaKey.instance.navKey.currentContext!).pushNamedAndRemoveUntil('/auth/login', (_) => false);
      }
    }
     

   handler.reject(err);
  }
}
