import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constansts.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function() toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text(
                'Sign up to Brew Crew',
                style: TextStyle(color: Colors.white70),
              ),
              actions: <Widget>[
                ElevatedButton.icon(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all<double>(0.0),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.brown[400]!),
                  ),
                  onPressed: () => widget.toggleView(),
                  label: const Text('Sign In', style: TextStyle(color: Colors.white70)),
                  icon: const Icon(Icons.person),
                ),
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                        ),
                        onChanged: (val) => setState(() => email = val),
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                        ),
                        obscureText: true,
                        onChanged: (val) => setState(() => password = val),
                        validator: (val) =>
                            val!.length < 6 ? 'Enter a password 6+ characters long' : null,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.pink[300]!), // Set the background color
                          padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0)), // Set padding
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            // Set the button shape
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          elevation:
                              WidgetStateProperty.all<double>(4.0), // Set the button elevation
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            debugPrint('$email, $password');
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              error = 'Please supply a valid email';
                              loading = false;
                            }
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.pink[300]),
                      )
                    ],
                  ),
                )),
          );
  }
}
