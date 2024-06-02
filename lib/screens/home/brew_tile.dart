import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: const AssetImage('assets/coffee_icon.png'),
            radius: 25,
            backgroundColor: Colors.brown[brew.strength!],
          ),
          title: Text(
            brew.name!,
            style: const TextStyle(fontFamily: 'Kanit-Bold'),
          ),
          subtitle: Text('Takes ${brew.sugar} sugar(s)'),
        ),
      ),
    );
  }
}
