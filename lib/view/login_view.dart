import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:plogger/home.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: FlutterLogin(
        logo: 'assets/logo.png',
        title: 'PLOGGER',
        theme: LoginTheme(accentColor: cs.onPrimary),
        onSignup: (p0) async {
          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: p0.name!,
              password: p0.password!,
            );
            return null;
          } catch (e) {
            return e.toString();
          }
        },
        onLogin: (p0) async {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: p0.name,
              password: p0.password,
            );
            return null;
          } catch (e) {
            return e.toString();
          }
        },
        onSubmitAnimationCompleted: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        },
        onRecoverPassword: (p0) {
          return null;
        },
        hideForgotPasswordButton: true,
      ),
    );
  }
}
