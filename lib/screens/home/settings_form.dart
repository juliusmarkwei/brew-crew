import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constansts.dart';
import 'package:brew_crew/models/user.dart' as u;
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final u.User? user = Provider.of<u.User?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final UserData userData = snapshot.data!;
            debugPrint('User sugar: ${userData.sugars}');

            // Calculate sliderValue safely
            double sliderValue = _currentStrength?.toDouble() ?? userData.strength.toDouble();
            // Calculate activeColor safely
            int strengthValue = _currentStrength ?? userData.strength;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 20.0),

                  TextFormField(
                    initialValue: _currentName ?? userData.name,
                    decoration: textInputDecoration,
                    onChanged: (val) => setState(() => _currentName = val),
                    validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  ),

                  const SizedBox(height: 20.0),

                  // dropdown
                  DropdownButtonFormField(
                    hint: const Text('Select sugar'),
                    value: _currentSugars ?? userData.sugars,
                    decoration: textInputDecoration,
                    items: sugars
                        .map((sugar) =>
                            DropdownMenuItem(value: sugar, child: Text('$sugar sugar(s)')))
                        .toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),

                  const SizedBox(height: 20.0),

                  // slider
                  Slider(
                    activeColor: Colors.brown[strengthValue],
                    inactiveColor: Colors.brown,
                    value: sliderValue,
                    onChanged: (val) => setState(() => _currentStrength = val.round()),
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                  ),

                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all<double>(0.0),
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.pink[400]!),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentStrength ?? userData.strength,
                          _currentName ?? userData.name,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
