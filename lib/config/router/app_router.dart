import 'package:go_router/go_router.dart';
import 'package:migu/presentation/auth/Additional_info_register_Screen.dart';
import 'package:migu/presentation/auth/Addpet_Screen.dart';
import 'package:migu/presentation/auth/login_screen.dart';
import 'package:migu/presentation/auth/register_Screen.dart';
import 'package:migu/presentation/home/add_antiparasitic_Screen.dart';
import 'package:migu/presentation/home/addvaccine_Screen.dart';
import 'package:migu/presentation/home/home_Screen.dart';

final appRouter = GoRouter(initialLocation: "/home/0", routes: [
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
      return AddVaccineScreen();
    },
  ),

   GoRoute(
    path: "/register",
    builder: (context, state) {
      return RegisterScreen();
    },
  ),

   GoRoute(
    path: "/additionalInfo",
    builder: (context, state) {
      return AdditionalInfoRegisterScreen();
    },
  ),
   GoRoute(
    path: "/addpet",
    builder: (context, state) {
      return AddPet();
    },
  ),

   GoRoute(
    path: "/login",
    builder: (context, state) {
      return LoginScreen();
    },
  ),

    GoRoute(
    path: "/Addantiparasitic",
    builder: (context, state) {
      return Addantiparasitic();
    },
  )
]);
