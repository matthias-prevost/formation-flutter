import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project0/shared/input.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage("assets/cocktail.png"),
            fit: BoxFit.cover,
          ),
          LoginBox(),
        ],
      ),
    );
  }
}

class LoginBox extends StatefulWidget {
  const LoginBox({super.key});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  String? email;
  String? password;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    email = "";
    password = "";
  }

  void onEmailChange(String value) {
    setState(() {
      email = value;
    });
  }

  void onPasswordChange(String value) {
    setState(() {
      password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Connexion',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Input(
                  placeholder: "Nom d'utilisateur",
                  onChanged: onEmailChange,
                ),
                const SizedBox(height: 16.0),
                Input(
                  placeholder: "Mot de passe",
                  onChanged: onPasswordChange,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (email == null || password == null) return;
                    setState(() {
                      loading = true;
                    });
                    await login(email!, password!);
                    setState(() {
                      loading = false;
                    });
                    context.go('/');
                  },
                  child: loading
                      ? SizedBox(
                          child: CircularProgressIndicator(),
                          width: 20,
                          height: 20,
                        )
                      : const Text('Connexion'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> login(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    print(e);
  } catch (e) {
    print(e);
  }
}
