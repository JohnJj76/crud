import 'package:firebase_auth/firebase_auth.dart';

// Logín
Future<void> signUserIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('error de email');
    } else if (e.code == 'wrong-password') {
      print('error de clave');
    }
  }
}

// Registrarse
Future<void> signUserUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('error de email');
    } else if (e.code == 'wrong-password') {
      print('error de clave');
    }
  }
}

// Cerrar sección
Future<void> signUserOut() async {
  await FirebaseAuth.instance.signOut();
}
