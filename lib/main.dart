import 'package:flutter/material.dart';
import 'package:newfp/auth.dart';
import 'package:newfp/screen/HomeScreen.dart';
import 'package:newfp/screen/add_booking.dart';
import 'package:newfp/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newfp/screen/sign_up_screen.dart';
import 'package:newfp/screen/update_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    title: "Youth Center",
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.purple),
          bannerTheme: const MaterialBannerThemeData(),
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Auth(),
        routes: {
          '/': (context) => Auth(),
          'signupScreen': (context) => const SignUpScreen(),
          "loginScreen": (context) => const LoginScreen(),
          "homeScreen": (context) => const HomeScreen(),
          // 'addBooking': (context) => const AddBooking(),
          'updateProfile': (context) => const UpdateProfile()
        });
  }
}
