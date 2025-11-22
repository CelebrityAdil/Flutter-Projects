import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tourism_app/firebase_options.dart';
import 'package:tourism_app/screens/authentication.dart';

import 'package:tourism_app/screens/favourites_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/onboard_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/detail_screen.dart';
import 'models/tour.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const TourismApp());
}

class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),

      initialRoute: '/splash',
      routes: {
        '/splash': (ctx) => const SplashScreen(),
        '/auth': (ctx) => const AuthForm(),
        '/onboard': (ctx) => const OnboardScreen(),
        '/home': (ctx) => HomeScreen(),
        '/profile': (ctx) =>
            const ProfileScreen(username: 'Guest', email: 'guest@example.com'),
        '/notifications': (ctx) => NotificationScreen(),
        FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == DetailScreen.routeName) {
          final args = settings.arguments as Tour;
          return MaterialPageRoute(builder: (ctx) => DetailScreen(tour: args));
        }
        return null;
      },
    );
  }
}
