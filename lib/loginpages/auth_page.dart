import 'package:crud/loginpages/Inicio_cession.dart';
//import 'package:crud/qrpages/addqr_page.dart';
import 'package:crud/qrpages/homeqr_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import '../pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //return const Home();
              //return const AddqrPage();
              return const HomeQrPage();
            } else {
              return const InicioCessionPage();
            }
          }),
    );
  }
}
