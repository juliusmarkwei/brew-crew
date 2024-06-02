import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 70),
            child: const SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>?>.value(
      initialData: null,
      value: DatabaseService().brew,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text(
            'Brew Crew',
            style: TextStyle(
              color: Colors.white70,
              fontFamily: 'Kanit',
              fontSize: 23.0,
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () async {
                // ignore: avoid_print
                print('Logout');
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('Logout'),
            ),
            TextButton.icon(
              onPressed: () => showSettingsPanel(),
              icon: const Icon(Icons.settings),
              label: const Text('settings'),
            )
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const BrewList()),
      ),
    );
  }
}
