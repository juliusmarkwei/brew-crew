import 'package:brew_crew/models/user.dart' as u;
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final u.User? user = Provider.of<u.User?>(context);

    // return either Home or Authenticate widget
    return (user == null) ? const Authenticate() : Home();
  }
}
