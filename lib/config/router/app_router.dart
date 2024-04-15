import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/config/router/app_route_notifier.dart';
import 'package:migu/presentation/auth/Additional_info_register_Screen.dart';
import 'package:migu/presentation/auth/Addpet_Screen.dart';
import 'package:migu/presentation/auth/TutorVetSelectionScreen.dart';
import 'package:migu/presentation/auth/login_screen.dart';
import 'package:migu/presentation/auth/register_Screen.dart';
import 'package:migu/presentation/home/add_antiparasitic_Screen.dart';
import 'package:migu/presentation/home/addvaccine_Screen.dart';
import 'package:migu/presentation/home/home_Screen.dart';
import 'package:migu/presentation/home/into_vaccine.dart';
import 'package:migu/presentation/home/vet/editvet_profile_Screen.dart';
import 'package:migu/presentation/home/vet/home_vet_Screen.dart';
import 'package:migu/presentation/views/vet/patient_view.dart';

// Obtén una instancia de Firebase Authentication
final FirebaseAuth _auth = FirebaseAuth.instance;

// Obtén una instancia de Firestore
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Función para obtener el rol del usuario desde Firestore
Future<String> getUserRole() async {
  final user = _auth.currentUser;
  if (user != null) {
    final userData = await _firestore.collection('users').doc("id").get();
    return userData['role'];
  } else {
    return "veterinario";
  }
}

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    refreshListenable: goRouterNotifier,
    initialLocation: "/home/0",
    routes: [
      GoRoute(
        path: "/home/:page",
        builder: (context, state) {
          final pageIndex = state.pathParameters["page"] ?? "0";
          return HomeScreen(
            pageIndex: int.parse(pageIndex),
          );

          // return FutureBuilder<String>(
          //            future: getUserRole(),
          //            builder: (context, snapshot) {
          //              if (snapshot.connectionState == ConnectionState.waiting) {
          //                return Text(""); // Muestra un indicador de carga mientras se obtiene el rol del usuario
          //              } else {
          //                final userRole = snapshot.data;
          //                if (userRole == 'veterinario') {
          //                  return const HomeVetScreen();
          //                } else {
          //                 return HomeScreen(
          //               pageIndex: int.parse(pageIndex),
          //            );
          //                }
          //              }
          //            },
          //          );

          //  return HomeScreen(
          //       pageIndex: int.parse(pageIndex),
          //    );
        },
      ),
       GoRoute(
        path: "/vet/:page",
        builder: (context, state) {
          final pageIndex = state.pathParameters["page"] ?? "0";
          return HomeVetScreen(
            pageIndex: int.parse(pageIndex),
          );
        },
      ),

      GoRoute(
        path: "/addvaccine",
        builder: (context, state) {
          return const AddVaccineScreen();
        },
      ),
      // GoRoute(
      //   path: "/patient",
      //   builder: (context, state) {
      //     return const PatientView();
      //   },
      // ),
        GoRoute(
             path: "/TutorVetSelectionScreen",
             builder: (context, state) {
               return const TutorVetSelectionScreen();
             },
           ),

      GoRoute(
        path: "/register",
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: "/additionalInfo",
        builder: (context, state) {
          return const AdditionalInfoRegisterScreen();
        },
      ),
      GoRoute(
        path: "/addpet",
        builder: (context, state) {
          return const AddPet();
        },
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: "/EditProfileScreen",
        builder: (context, state) {
          return const EditProfileScreen();
        },
      ),


      GoRoute(
        path: "/IntoVaccine",
        builder: (context, state) {
          return const IntoVaccine();
        },
      ),

      GoRoute(
        path: "/Addantiparasitic",
        builder: (context, state) {
          return const Addantiparasitic();
        },
      )
    ],
    redirect: (context, state) {
      //tiene que estar no autenticado pero ser veterinario y cuando preicone veterinario pasarlo a true y el redirect lo llevara a el bottom home tab con las rutas 
      final isGoingTo = state.matchedLocation;
      print("esvetis${goRouterNotifier.isVet}");
      if (goRouterNotifier.isAuthenticated) {
        if (goRouterNotifier.isVet) {
          // Redirige a la pantalla para veterinarios
          if (isGoingTo == '/home/0' ||
              isGoingTo == '/home/1' ||
              isGoingTo == '/addvaccine' ||
              isGoingTo == '/addpet' ||
              isGoingTo == '/IntoVaccine' ||
              isGoingTo == "/Addantiparasitic") return null;
          return "/home/0";
        } else {
      
           if (isGoingTo == '/vet/0' ||
              isGoingTo == '/vet/1' ||
              isGoingTo=="/EditProfileScreen"
            ) return null;
            return "/vet/0";
          // Redirige a la pantalla para usuarios no veterinarios
          // Aquí puedes manejar las rutas específicas para usuarios no veterinarios
        }
      } else {
        // Si el usuario no está autenticado, redirige a la pantalla de registro
        if (isGoingTo == '/register' ||
            isGoingTo == '/login' ||
            isGoingTo == '/additionalInfo' ||
            isGoingTo == "/TutorVetSelectionScreen") return null;
        return '/register';
      }
    },
  );
});
