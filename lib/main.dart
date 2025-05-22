import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/consts/routes/app_routes.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/consts/services/loading_service.dart';
import 'package:Hoppr/consts/theme_data.dart';
import 'package:Hoppr/firebase_options.dart';
import 'package:Hoppr/presentation/sign/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://odtozfcoqvljosaedsiy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9kdG96ZmNvcXZsam9zYWVkc2l5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQzMzE1NTIsImV4cCI6MjA1OTkwNzU1Mn0.JbQ1NNNxnRBhksC7qXRHgpq6fle7eIZBntpAO5PTspo',
  );
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hoppr',
        // theme: Styles.themeData(isDarktheme: themeProvider.getIsDarkTheme, context: context),
        onGenerateRoute: AppRoutes.onGeneratedRoute,
        initialRoute: PagesRouteName.initial,
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(
          builder: BotToastInit(),
        ),
        ),
    );
  }
}



