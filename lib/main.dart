import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signUp_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBI-iohEruUW9vsuqs-P50NLtIhpW7SoqI",
      appId: "1:520177409679:web:dd6c591f82440b2fef9afa",
      messagingSenderId: "520177409679",
      projectId: "flutter-application-d6975",
      authDomain: "flutter-application-d6975.firebaseapp.com",
      databaseURL:
          "https://flutter-application-d6975-default-rtdb.firebaseio.com",
      storageBucket: "flutter-application-d6975.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Instagram',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
       /*  home: const ResponsiveLayout(
            webScreenLayout: WebLayout(), mobileScreenLayout: MobileLayout()) */
        home: const SigninScreen(),
            );
  }
}
