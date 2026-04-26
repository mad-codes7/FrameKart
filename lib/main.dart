import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/onboarding_screen.dart';
import 'screens/app_shell.dart';
import 'screens/login_screen.dart';
import 'services/favorites_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://iyxrjiqrrhpkfidpsbtg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5eHJqaXFycmhwa2ZpZHBzYnRnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzcxODMxNDAsImV4cCI6MjA5Mjc1OTE0MH0.3EcJUaeTOPqxstSDNhCgKoIqlt49Govn20fVAzYiC6k',
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;

  // Session is auto-restored by Supabase
  final isLoggedIn = Supabase.instance.client.auth.currentUser != null;

  final favoritesService = FavoritesService();
  if (isLoggedIn) {
    await favoritesService.loadFromSupabase();
  }

  runApp(FurnitureARApp(
    onboardingSeen: onboardingSeen,
    isLoggedIn: isLoggedIn,
    favoritesService: favoritesService,
  ));
}

class FurnitureARApp extends StatelessWidget {
  final bool onboardingSeen;
  final bool isLoggedIn;
  final FavoritesService favoritesService;

  const FurnitureARApp({
    super.key,
    required this.onboardingSeen,
    required this.isLoggedIn,
    required this.favoritesService,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFC97B4B);

    Widget home;
    if (!onboardingSeen) {
      home = const OnboardingScreen();
    } else if (!isLoggedIn) {
      home = LoginScreen(favoritesService: favoritesService);
    } else {
      home = AppShell(favoritesService: favoritesService);
    }

    return MaterialApp(
      title: 'FrameKart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFAF7F2),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          brightness: Brightness.light,
          surface: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Color(0xFF3D2B1F),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Color(0xFF3D2B1F)),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
        ),
      ),
      routes: {
        '/home': (_) => AppShell(favoritesService: favoritesService),
        '/login': (_) => LoginScreen(favoritesService: favoritesService),
      },
      home: home,
    );
  }
}
