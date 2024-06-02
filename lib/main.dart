import 'package:brew_crew/firebase_options.dart';
import 'package:brew_crew/models/user.dart' as u;
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<u.User?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black87), // This sets the icon color
            titleTextStyle: TextStyle(
              fontFamily: 'Kanit',
            ), // This sets the title text color
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
      ),
    );
  }
}
