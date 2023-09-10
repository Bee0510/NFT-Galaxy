import 'package:flutter/material.dart';

import '../Auth/Auth.dart';

class SignIN extends StatefulWidget {
  const SignIN({super.key});

  @override
  State<SignIN> createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  final Authentication _authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _authentication.signInwithGoogle();
          },
          child: Text('Sign i with Google'),
        ),
      ),
    );
  }
}
