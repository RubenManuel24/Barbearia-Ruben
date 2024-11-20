import 'package:barbearia_rb/src/core/exceptions/auth_exception.dart';
import 'package:barbearia_rb/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/fp/nil.dart';
import 'package:barbearia_rb/src/model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(({
    String name, 
    String email,
    String password
  }) userData);


  Future<Either<RepositoryException, List<UserModel>>> getEmployee (int barbershopId);

  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(({
    List<String> weekDays, 
    List<int> weekHours
    }) usedata);


   Future<Either<RepositoryException, Nil>> registerEmployee(({
    String name,
    String email,
    String password,
    int barbershopId,
    List<String> weekDays, 
    List<int> weekHours
    }) usedata);


}
