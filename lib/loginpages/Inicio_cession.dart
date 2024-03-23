import 'package:crud/loginpages/login_page.dart';
import 'package:crud/loginpages/register_page.dart';
import 'package:flutter/material.dart';

class InicioCessionPage extends StatefulWidget {
  const InicioCessionPage({super.key});

  @override
  State<InicioCessionPage> createState() => _InicioCessionPageState();
}

class _InicioCessionPageState extends State<InicioCessionPage> {
  bool showLoginPage = true;
  void tooglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: tooglePages);
    } else {
      return RegisterPage(onTap: tooglePages);
    }
  }
}
