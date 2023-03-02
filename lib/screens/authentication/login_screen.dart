import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/services/auth_service.dart';
import 'package:storyteller/services/validator_service.dart';
import 'package:storyteller/wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();

  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Firebase Authentication'),
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  //const Text('Provide your email address and password to sign in'),
                  //const Text('Provide your email address and password to sign in', textAlign: TextAlign.center,
                      //style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 64),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailTextController,
                          //focusNode: _focusEmail,
                          validator: (value) => Validator.validateEmail(email: value!),
                          decoration: const InputDecoration(
                            hintText: 'Email address',
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _passwordTextController,
                          //focusNode: _focusPassword,
                          obscureText: true,
                          validator: (value) => Validator.validatePassword(password: value!),
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              User? user = await AuthService.signInUsingEmailPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text,
                                context: context,
                              );
                              if (user != null) {
                                if (mounted) {
                                  Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: const Wrapper()),
                                          (Route<dynamic> route) => false);
                                }
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text( 'Incorrect username and/or password. Try again.',),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}