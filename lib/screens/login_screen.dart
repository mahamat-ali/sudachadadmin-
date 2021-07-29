import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sudachadadmin/screens/home_screen.dart';
import 'package:sudachadadmin/theme/btn_style.dart';
import 'package:sudachadadmin/theme/input_border.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = ' ';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 150.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: fieldBorder('Email', theme),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'S\'il vous plait entrer votre email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: fieldBorder('Mot de passe', theme),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'S\'il vous plait entrer votre mot de pass';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(
                        height: 120,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            context.loaderOverlay.show();
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return HomeScreen(
                                    uid: userCredential.user!.uid,
                                  );
                                },
                              ),
                            );
                            context.loaderOverlay.hide();
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        },
                        child: Text('Login'),
                        style: bntStyle(
                          context,
                          theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
