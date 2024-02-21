import 'package:flutter/material.dart';
import 'package:migu/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<UserApp> login(String email, String password,BuildContext context);
  Future<UserApp> register(String email, String password, String fullName,BuildContext context);
}
