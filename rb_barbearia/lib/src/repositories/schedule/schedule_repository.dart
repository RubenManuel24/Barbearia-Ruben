import 'package:barbearia_rb/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/fp/nil.dart';
import 'package:barbearia_rb/src/model/schedule_model.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException, Nil>> scheduleClient(
      ({
        int barbershopId,
        int userId,
        String nameClient,
        DateTime date,
        int time
      }) scheduleData);

  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({
        DateTime date, 
        int userId
      }) filterData);
}
