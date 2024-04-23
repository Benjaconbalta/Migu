import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/presentation/providers/auth/auth_provider.dart';

// rules_version = '2';

// ​

// service cloud.firestore {

//   match /databases/{database}/documents {

//     match /users/{userId}/{document=**} {

//       allow read, write: if request.auth.uid == userId;

//     }

//   }

// }

 final authProvider = Provider((ref) => FirebaseAuth.instance);
// final goRouterNotifierProvider = Provider((ref) {
//   final auth = ref.read(authProvider);
//   final firestore = FirebaseFirestore.instance;
//   final goRouterNotifier = GoRouterNotifier();

//   // Función para obtener el rol del usuario
//   Future<void> obtenerRolUsuario(String userId) async {
//     final userData = await firestore.collection('users').doc(userId).get();
//     print(userData.data()!["role"]);
//     final isVet = userData.data()!['role'] ?? true;
//     goRouterNotifier.setVetStatus(isVet);
//   }

//   // Escuchar cambios en el estado de autenticación
//   auth.authStateChanges().listen((user) async {
//     if (user != null) {
//       // El usuario ha iniciado sesión, actualizar el estado de autenticación
//       goRouterNotifier.setAuthStatus(true);

//       if (user.isAnonymous) {
//         // Si el usuario ha iniciado sesión de forma anónima, obtén el uid anónimo
//         // String anonymousUid = await firestore.collection('anonymous_users').add({}).then((docRef) => docRef.id);
//         String anonymousUid = user.uid;

//         // Actualizamos el rol del usuario utilizando su UID anónimo
//         await obtenerRolUsuario(anonymousUid);
//         // Obtén el rol del usuario utilizando el uid anónimo
//         // await obtenerRolUsuario(anonymousUid);
//       } else {
//         // Si el usuario no ha iniciado sesión de forma anónima, no es necesario obtener el rol
//       }
//     } else {
//       // El usuario no ha iniciado sesión, restablecer el estado de autenticación y el estado del veterinario
//       goRouterNotifier.setAuthStatus(false);
//       goRouterNotifier.setVetStatus(false);
//     }
//   });

//
//   return goRouterNotifier;
// });
//  final goRouterNotifierProvider = Provider((ref) {
//    final auth = ref.read(authProvider);
//    final firestore = FirebaseFirestore.instance;
//    final goRouterNotifier = GoRouterNotifier();
//  //aca obtener id de forma anonima
//    auth.authStateChanges().listen((user) async {

//      if (user != null) {
//        goRouterNotifier.setAuthStatus(true);
//        final userData =
//        //cambiar id a el de la forma anonima
//            await firestore.collection('users').doc(user.uid).get();
//        print(userData.data()!["role"]);
//        final isVet = userData.data()!['role'] ??
//            true; // assuming 'isvet' is a boolean field
//        goRouterNotifier.setVetStatus(isVet);
//      } else {
//        goRouterNotifier.setAuthStatus(false);
//        goRouterNotifier
//            .setVetStatus(false); // Reset vet status when user logs out
//      }
//    });

//    return goRouterNotifier;
//  });

// class GoRouterNotifier extends ChangeNotifier {
//   bool _isAuthenticated = false;
//   bool _isVet = true;

//   bool get isAuthenticated => _isAuthenticated;
//   bool get isVet => _isVet;

//   void setAuthStatus(bool value) {
//     _isAuthenticated = value;
//     notifyListeners();
//   }

//   void setVetStatus(bool value) {
//     _isVet = value;
//     notifyListeners();
//   }
// }

//  final authProvider = Provider((ref) => FirebaseAuth.instance);
 final goRouterNotifierProvider = Provider((ref) {
   final auth = ref.read(authProvider);
   final goRouterNotifier = GoRouterNotifier();

   auth.authStateChanges().listen((user) {
     if (user != null) {
       goRouterNotifier.setAuthStatus(true);
     } else {
       goRouterNotifier.setAuthStatus(false);
     }
   });

   return goRouterNotifier;
 });

 class GoRouterNotifier extends ChangeNotifier {
   bool _isAuthenticated = false;

   bool get isAuthenticated => _isAuthenticated;

   void setAuthStatus(bool value) {
     _isAuthenticated = value;
     notifyListeners();
   }
 }
