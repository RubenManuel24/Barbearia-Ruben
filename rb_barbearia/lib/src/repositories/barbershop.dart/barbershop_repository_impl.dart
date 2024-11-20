import 'dart:developer';

import 'package:barbearia_rb/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/fp/nil.dart';
import 'package:barbearia_rb/src/core/restClient/rest_client.dart';
import 'package:barbearia_rb/src/model/barbershop_model.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:barbearia_rb/src/repositories/barbershop.dart/barbershop_repository.dart';
import 'package:dio/dio.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  BarbershopRepositoryImpl({
    required this.restClient,
  });

  RestClient restClient;
  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth
            .get('/barbershop', queryParameters: {'user_id': '#userAuthRef'});
        return Sucess(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) =
            await restClient.auth.get('/barbershop/${userModel.barberShopId}');
        return Sucess(BarbershopModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(
      ({
        String email,
        String name,
        List<String> openingDays,
        List<int> openingHours
      }) data) async {
    try {
  await restClient.auth.post('/barbershop', data: {
    'email': data.email,
    'name': data.name,
    'opening_days': data.openingDays,
    'opening_hours': data.openingHours
  });
  return Sucess(nil);
} on DioException catch (e, s) {
  
  log('Erro ao registar barbearia', error: e, stackTrace: s);
  return Failure(RepositoryException(message: 'Erro ao registar barbearia'));
}
  }
}
