import 'dart:developer';
import 'dart:io';

import 'package:barbearia_rb/src/core/exceptions/auth_exception.dart';
import 'package:barbearia_rb/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/fp/nil.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:barbearia_rb/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

import '../../core/restClient/rest_client.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Sucess(data["access_token"]);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválida', error: e, stackTrace: s);
          return Failure(AuthUnAuthorizedException());
        }
      }
      log('Erro ao realizar Login', error: e, stackTrace: s);
      return Failure(AuthErrorException(message: 'Erro ao realizar Login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Sucess(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar usuário logado'));
    } on ArgumentError catch (e, s) {
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'profile': 'ADM'
      });

      return Sucess(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar um usuário admin', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao registrar um usuário admin'));
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModel>>> getEmployee(int barbershopId) async {
    try {
      final Response(: List data) = await restClient.auth.get('/users', queryParameters: {'barbershop_id': barbershopId});

      final employee = data.map((e) => UserModelEmployee.fromMap(e)).toList();

      return Sucess(employee);
    } on DioException catch (e, s) {
      log('Erro ao buscar colaboradores', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao buscar colaboradores'));

    } on ArgumentError catch (e, s) {
      log('Erro ao converter colaboradores', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao buscar colaboradores'));

    }
  }
  
  @override
  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(({List<String> weekDays, List<int> weekHours}) usedata)  async {
    try {
  final userModelResult = await me();
  
  final int userId;
  
  switch(userModelResult){
    case Sucess(value: UserModel(:var id)):
      userId = id;
    case Failure(:var exception):
    return Failure(exception);
  }
  
  await restClient.auth.put('/users/$userId', data: {
    'work_days': usedata.weekDays,
    'work_hours': usedata.weekHours
  });
  
  return Sucess(nil);
} on DioException catch (e, s) {
   log('Erro ao inserir administrador com colaborador', error: e, stackTrace: s);
   return Failure(RepositoryException(message: 'Erro ao inserir administrador com colaborador'));
}
  }
  
  @override
  Future<Either<RepositoryException, Nil>> registerEmployee(({
    int barbershopId, 
    String email, 
    String name, 
    String password, 
    List<String> weekDays, 
    List<int> weekHours}) usedata) async {

    
    try {
  await restClient.auth.post('/users/', data: {
    'name': usedata.name,
    'email': usedata.email,
    'password': usedata.password,
    'barbershop_id': usedata.barbershopId,
    'profile':'EMPLOYEE',
    'work_days': usedata.weekDays,
    'work_hours': usedata.weekHours
  });
  
  return Sucess(nil);
} on DioException catch (e, s) {
  log('Erro ao inserir administrador com colaborador', error: e, stackTrace: s);
   return Failure(RepositoryException(message: 'Erro ao inserir administrador com colaborador'));
}
  
    
  }
}
