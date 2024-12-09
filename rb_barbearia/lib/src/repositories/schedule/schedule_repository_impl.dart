import 'dart:developer';

import 'package:barbearia_rb/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/fp/nil.dart';
import 'package:barbearia_rb/src/core/restClient/rest_client.dart';
import 'package:barbearia_rb/src/model/schedule_model.dart';
import 'package:dio/dio.dart';
import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, Nil>> scheduleClient(
      ({
        int barbershopId,
        DateTime date,
        String nameClient,
        int time,
        int userId
      }) scheduleData) async {
    try {
      await restClient.auth.post('/schedules', data: {
        'barbershop_id': scheduleData.barbershopId,
        'user_id': scheduleData.userId,
        'client_name': scheduleData.nameClient,
        'time': scheduleData.time,
        'date': scheduleData.date.toString(),
      });
      return Sucess(nil);
    } on DioException catch (e, s) {
      log("erro ao registar agendamento", error: e, stackTrace: s);
      return Failure(RepositoryException(message: "erro ao agendar horário"));
    }
  }

  @override
  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({DateTime date, int userId}) filterData) async {
    try {
      final Response(:List data) = await restClient.auth.get('/schedules',
          queryParameters: {
            "user_id": filterData.userId,
            "date": filterData.date.toIso8601String()
          });

      final scheduleData = data.map((s) => ScheduleModel.fromMap(s)).toList();

      return Sucess(scheduleData);
    } on DioException catch (e, s) {
      log("Erro ao buscar agendamento de uma data", error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: "Erro ao buscar agendamento de uma data"));
    } on ArgumentError catch (e, s) {
      log("JSON Invalid", error: e, stackTrace: s);
      return Failure(RepositoryException(message: "JSON Invalid"));
    }
  }
}
