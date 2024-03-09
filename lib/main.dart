import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/config/router/app_router.dart';
import 'package:migu/config/theme/app_theme.dart';
import 'package:migu/firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
     runApp(const ProviderScope(
      child: MainApp(),
    ));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
_MainAppState createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
          final approuter = ref.watch(goRouterProvider);
    return  MaterialApp.router( 
       routerConfig: approuter,
       debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
     
    );
  }
}
