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
  final goRouterNotifierProvider = Provider((ref) {
    final auth = ref.read(authProvider);
    final firestore = FirebaseFirestore.instance;
    final goRouterNotifier = GoRouterNotifier();

    auth.authStateChanges().listen((user) async {
      if (user != null) {
        goRouterNotifier.setAuthStatus(true);
        final userData =
            await firestore.collection('users').doc("ok7l2yAWkoyyLdSEgHXK").get();
        print(userData.data()!["role"]);
        final isVet = userData.data()!['role'] ??
            true; // assuming 'isvet' is a boolean field
        goRouterNotifier.setVetStatus(isVet);
      } else {
        goRouterNotifier.setAuthStatus(true);
        goRouterNotifier
            .setVetStatus(false); // Reset vet status when user logs out
      }
    });

    return goRouterNotifier;
  });

  class GoRouterNotifier extends ChangeNotifier {
    bool _isAuthenticated = false;
    bool _isVet = true;

    bool get isAuthenticated => _isAuthenticated;
    bool get isVet => _isVet;

    void setAuthStatus(bool value) {
      _isAuthenticated = value;
      notifyListeners();
    }

    void setVetStatus(bool value) {
      _isVet = value;
      notifyListeners();
    }
  }


// final authProvider = Provider((ref) => FirebaseAuth.instance);
// final goRouterNotifierProvider = Provider((ref) {
//   final auth = ref.read(authProvider);
//   final goRouterNotifier = GoRouterNotifier();

//   auth.authStateChanges().listen((user) {
//     if (user != null) {
//       goRouterNotifier.setAuthStatus(true);
//     } else {
//       goRouterNotifier.setAuthStatus(false);
//     }
//   });

//   return goRouterNotifier;
// });

// class GoRouterNotifier extends ChangeNotifier {
//   bool _isAuthenticated = false;

//   bool get isAuthenticated => _isAuthenticated;

//   void setAuthStatus(bool value) {
//     _isAuthenticated = value;
//     notifyListeners();
//   }
// }