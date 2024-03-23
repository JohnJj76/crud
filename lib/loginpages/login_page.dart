import 'package:flutter/material.dart';
import '../services/firebase_auth.dart';
import 'components/my_button.dart';
import 'components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              // logo
              const Icon(
                Icons.lock,
                size: 60,
              ),
              SizedBox(height: 50),
              Text(
                '¡Bienvenido nuevamente!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 25),
              // password textfield
              MyTextField(
                controller: emailController,
                hintText: 'Correo',
                obscureText: false,
              ),
              SizedBox(height: 20),
              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Clave',
                obscureText: true,
              ),
              SizedBox(height: 18),
              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '¿Has olvidado la contraseña?',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // sign in button
              MyButton(
                text: 'Ingresar',
                onTap: () {
                  //
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  //
                  signUserIn(emailController.text, passwordController.text);
                  //
                  Navigator.pop(context);
                },
              ),

              SizedBox(height: 20),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'continuar con',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Si no estas registrado!',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Registrate',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
