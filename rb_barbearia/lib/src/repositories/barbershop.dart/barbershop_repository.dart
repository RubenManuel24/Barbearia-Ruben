import 'package:barbearia_rb/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/fp/nil.dart';
import 'package:barbearia_rb/src/model/barbershop_model.dart';
import 'package:barbearia_rb/src/model/user_model.dart';

abstract class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(UserModel userModel);

  Future<Either<RepositoryException, Nil>> save(({
    String name,
    String email,
    List<String> openingDays,
    List<int> openingHours
  }) data);

}