import 'package:flutter/material.dart';
import 'package:messenger/services/authentication.dart';
import 'package:messenger/shared/constants.dart';
import 'package:messenger/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService instance = AuthService();

  final _key = GlobalKey<FormState>();

  late String email;

  late String password;

  late String name;

  late String error;

  bool showError = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(title: const Text("Register"), actions: [
              TextButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: const Text("Login"))
            ]),
            body: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset(
                        "assets/eagle-logo.png",
                        fit: BoxFit.contain,
                      )),
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Full name"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a name";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter an email";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.length <= 6) {
                              return "Please enter a password 6+ characters long";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.purple.shade800),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15))),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              dynamic response =
                                  await instance.registerWithEmailPassword(
                                      email, password, name);
                              if (response is String) {
                                setState(() {
                                  isLoading = false;
                                  showError = true;
                                  error = response;
                                });
                              }
                            }
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showError
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            error,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
  }
}
