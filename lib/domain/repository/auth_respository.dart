import 'package:flutter/material.dart';
import 'package:migu/domain/entities/user.dart';

abstract class AuthRepository {
  Future<UserApp> login(String email, String password, BuildContext context);
  Future<UserApp> register(String email, String password, String fullName,BuildContext context);
  Future<void> googleLogin();
  Future<void> logout();
}
