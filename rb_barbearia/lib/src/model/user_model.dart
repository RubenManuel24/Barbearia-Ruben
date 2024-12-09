import 'package:flutter/foundation.dart';

sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
        required this.id, 
        required this.name, 
        required this.email, 
        this.avatar
        });

        factory UserModel.fromMap(Map<String, dynamic> json){
       return switch(json['profile']){
         'ADM' => UserModelADM.fromMap(json),
         'EMPLOYEE' => UserModelEmployee.fromMap(json),
         _=> throw ArgumentError('User Profile not found')
      };
    }
    
    
}

class UserModelADM extends UserModel {
  final List<dynamic>? workDays;
  final List? workHours;

  UserModelADM(
      {this.workDays,
      this.workHours,
      required super.id,
      required super.name,
      required super.email,
      super.avatar});

  factory UserModelADM.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email
      } =>
        UserModelADM(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          workDays: json['work_days']?.cast(),
          workHours: json['work_hours']?.cast(),
        ),
      _ => throw ArgumentError('Invalid Json')
    };
  }
}

class UserModelEmployee extends UserModel {
  final List<dynamic> workDays;
  final List workHours;
  final int barberShopId;

  UserModelEmployee(
      {required this.barberShopId,
      required this.workDays,
      required this.workHours,
      required super.id,
      required super.name,
      required super.email,
      super.avatar});

  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barbershop_id': final int barberShopId,
        'work_days': final List workDay,
        'work_hours': final List workHour
      } =>
        UserModelEmployee(
          id: id,
          name: name,
          email: email,
          barberShopId: barberShopId,
          avatar: json['avatar'],
          workDays: workDay.cast(),
          workHours: workHour.cast(),
        ),
      _ => throw ArgumentError('Invalid Json')
    };
  }
}
