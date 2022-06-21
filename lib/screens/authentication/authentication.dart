import 'package:flutter/material.dart';
import 'package:messenger/screens/authentication/login.dart';
import 'package:messenger/screens/authentication/register.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool _showLogin = true;

  void _changeView() {
    setState(() {
      _showLogin = !_showLogin;    
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showLogin ? Login(toggleView: _changeView,) : Register(toggleView: _changeView,);
  }
}
