import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:migu/domain/datasource/auth_datasource.dart';
import 'package:migu/domain/entities/user.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<UserApp> login(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = credential.user;
      if (user != null) {
        // El usuario ha iniciado sesión correctamente.
        final uid = user.uid; // Aquí obtienes el UID del usuario.

        return UserApp(
          uid: uid,
          email: email,
          fullName: "",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Usuario No Encontrado❌",
        )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Contraseña Icorrecta❌")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error del servidor$e")));
    }
    throw Exception('Error inesperado: ');
  }

  @override
  Future<UserApp> register(String email, String password, String fullName,
      BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //     .then(
      //   (value) {
      //     FirebaseFirestore.instance
      //         .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("pet")
      //         .add({"photo": "photodesderegister", "namePet": "none", "typepet": "none"});
      //   },
      // );
      return UserApp(
          uid: credential.user!.uid,
          email: credential.user!.email!,
          fullName: "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Contraseña muy devil")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("La Cuenta ya existe")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error del servidor${e}")));
    }
    throw Exception('Error inesperado: ');
  }
}
