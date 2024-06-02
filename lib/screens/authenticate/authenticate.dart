import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() => setState(() => showSignIn = !showSignIn);

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}
