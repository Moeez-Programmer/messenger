import 'package:flutter/material.dart';
import 'package:messenger/screens/home/user_list.dart';
import 'package:messenger/services/authentication.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService instance = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eagle Send"),
        actions: [
          TextButton.icon(
            onPressed: () {
              instance.signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: UserList(),
    );
  }
}
