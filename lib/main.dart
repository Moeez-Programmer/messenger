import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/services/authentication.dart';
import 'package:messenger/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: const Wrapper(),
      )
    );
  }
}
