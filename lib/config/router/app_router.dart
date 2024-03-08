import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/config/router/app_route_notifier.dart';
import 'package:migu/presentation/auth/Additional_info_register_Screen.dart';
import 'package:migu/presentation/auth/Addpet_Screen.dart';
import 'package:migu/presentation/auth/login_screen.dart';
import 'package:migu/presentation/auth/register_Screen.dart';
import 'package:migu/presentation/home/add_antiparasitic_Screen.dart';
import 'package:migu/presentation/home/addvaccine_Screen.dart';
import 'package:migu/presentation/home/home_Screen.dart';
import 'package:migu/presentation/home/into_vaccine.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
        refreshListenable: goRouterNotifier,
    initialLocation: "/home/0", routes: [
    GoRoute(
      path: "/home/:page",
      builder: (context, state) {
        final pageIndex = state.pathParameters["page"] ?? "0";
        return HomeScreen(
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
        return  const LoginScreen();
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
      final isGoingTo = state.matchedLocation;
      if (goRouterNotifier.isAuthenticated) {
        if (isGoingTo == '/home/0' ||
            isGoingTo == '/home/1' ||
            isGoingTo == '/addvaccine' ||
               isGoingTo == '/addpet' ||
                 isGoingTo == '/IntoVaccine' ||


            isGoingTo == "/Addantiparasitic" 
         

           ) return null;
        return "/home/0";
      } else {
        if (isGoingTo == '/register' ||
          // isGoingTo == '/addpet' ||
            isGoingTo == '/login' ||
             isGoingTo == '/additionalInfo' 
            ) return null;

        return '/register';
      }

      return null;
      }
  );
});
