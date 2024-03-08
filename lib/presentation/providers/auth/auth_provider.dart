
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/domain/entities/user.dart';
import 'package:migu/domain/repository/auth_respository.dart';
import 'package:migu/infrastrocture/repository/auth_repository_impl.dart';


final authProvider = StateNotifierProvider<AuthNotifier, UserApp>((ref) {
  final authRepositoy = AuthRepositoryImpl();
  return AuthNotifier(authRepository: authRepositoy);
});

class AuthNotifier extends StateNotifier<UserApp> {
  final AuthRepository authRepository;
  AuthNotifier({required this.authRepository}) : super(UserApp(email: "",fullName: "",uid: ""));

  Future<void> loginUser(String email, String password,BuildContext context) async {
    try {
      final user = await authRepository.login(email, password,context);
      print("user$user");
    } catch (e) {
      print("error");
    }
  }

  Future<void> registerUser(String email, String password,BuildContext context) async {
    try {
      final userregister =
          await authRepository.register(email, password, "sdasdasdsadas",context);
    
    } catch (e) {
      // logout();
    }
  }

  Future<void> logoutapp() async {
     await FirebaseAuth.instance.signOut();
  }


}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final UserApp? user;
  final String errormessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errormessage = ""});

  AuthState copywith({
    AuthStatus? authStatus,
    UserApp? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errormessage: errormessage ?? this.errormessage,
      );
}
