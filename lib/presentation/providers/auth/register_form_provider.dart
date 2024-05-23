//el state

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:migu/infrastrocture/inputs/email.dart';
import 'package:migu/infrastrocture/inputs/inputs.dart';
import 'package:migu/infrastrocture/inputs/lastname.dart';
import 'package:migu/infrastrocture/inputs/name.dart';
import 'package:migu/presentation/providers/auth/auth_provider.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Name name;
  final Email email;
  final LastName lasname;

  final Password password;

  RegisterFormState(
      {
      this.lasname=const LastName.pure(),
      this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.name = const Name.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  copywith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Name? name,
    Email? email,
    Password? password,
    LastName? lasname
  }) =>
      RegisterFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          lasname: lasname ?? this.lasname
          );
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, BuildContext context) registerUserCallback;
  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

  onNameChange(String value) {
    final newName = Name.dirty(value);
    state = state.copywith(
        name: newName,
        isValid: Formz.validate([newName, state.email, state.password]));
  }

    onlastNameChange(String value) {
    final newLastName = LastName.dirty(value);
    state = state.copywith(
        lasname: newLastName,
        isValid: Formz.validate([newLastName, state.email, state.password]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copywith(
        email: newEmail,
        isValid: Formz.validate([newEmail, state.name, state.password]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copywith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email, state.name]));
  }

  onFormSubmit(BuildContext context) async {
    _touchEveryField();
    if (!state.isValid) return;

    await registerUserCallback(
        state.email.value, state.password.value, context);
  }

  _touchEveryField() {
    //esto es para cuando el usuario envia el formulario sin antes rellenar nada
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final name = Name.dirty(state.name.value);
     final lastName = LastName.dirty(state.lasname.value);
    state = state.copywith(
        name: name,
        isFormPosted: true,
        email: email,
        password: password,
        lasname:lastName ,
        isValid: Formz.validate([email, password, name])
        );
  }
}

final registerformProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});
