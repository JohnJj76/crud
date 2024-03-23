import 'package:crud/services/google_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase_auth.dart';
import 'components/my_button.dart';
import 'components/my_textfield.dart';
import 'components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final conpasswordController = TextEditingController();

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
                size: 40,
              ),
              SizedBox(height: 20),
              Text(
                'Registrate para que puedas accesar',
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
              SizedBox(height: 10),
              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Clave',
                obscureText: true,
              ),
              SizedBox(height: 10),
              // confirmar password textfield
              MyTextField(
                controller: conpasswordController,
                hintText: 'Confirmar clave',
                obscureText: true,
              ),
              SizedBox(height: 15),
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

              const SizedBox(height: 20),

              // sign in button
              MyButton(
                text: 'Registrarse',
                onTap: () {
                  //
                  if (passwordController.text == conpasswordController.text) {
                    signUserUp(emailController.text, passwordController.text);
                  } else {
                    //
                    //showErrorMessage('Confirmación de password invalida');
                  }
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
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'assets/images/google.png'),
                ],
              ),
              const SizedBox(height: 20),
              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Si ya estas registrado!',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Ingresa',
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
