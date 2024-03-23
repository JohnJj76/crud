import 'package:crud/loginpages/auth_page.dart';
import 'package:crud/loginpages/login_page.dart';
import 'package:crud/pages/add_nombre_page.dart';
import 'package:crud/pages/edit_nombre_page.dart';
import 'package:crud/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/home': (context) => const Home(),
        '/login': (context) => LoginPage(
              onTap: () {},
            ),
        '/add': (context) => const AddNombrePage(),
        '/edit': (context) => const EditNombrePage(),
      },
    );
  }
}
