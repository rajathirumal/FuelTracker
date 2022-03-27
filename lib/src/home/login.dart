import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 200, 20, 20),
          child: Column(
            // root column
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // welcome column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Welcome Back,",
                    style: TextStyle(fontSize: 35.0),
                  ),
                  Text(
                    "Sign in to continue",
                    style: TextStyle(fontSize: 25.0),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // fields column
              Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black26,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please valid email.(Example: user@domain.com)';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black26,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        obscureText: true,
                        controller: passController,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    style:
                        ButtonStyle(elevation: MaterialStateProperty.all(20)),
                    icon: const Icon(Icons.login, color: Colors.white),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthenticationService>().signIn(
                            email: emailController.text,
                            password: passController.text);
                      }
                    },
                    label: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ]),
              )
            ],
          )
          // Container(
          //   color: Colors.greenAccent,
          // )
          ),
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20.0),
      //     child: Form(
      //       key: _formKey,
      //       child: Column(children: [
      //         TextFormField(
      //           // The validator receives the text that the user has entered.
      //           keyboardType: TextInputType.emailAddress,
      //           controller: emailController,
      //           decoration: const InputDecoration(hintText: "Email"),
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return 'Please valid email.(Example: user@domain.com)';
      //             }
      //             return null;
      //           },
      //         ),
      //         TextFormField(
      //           obscureText: true,
      //           controller: passController,
      //           decoration: const InputDecoration(hintText: "Password"),
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return 'Please enter password';
      //             }
      //             return null;
      //           },
      //         ),
      //         const SizedBox(height: 20.0),
      //         ElevatedButton.icon(
      //           icon: const Icon(Icons.login, color: Colors.white),
      //           onPressed: () {
      //             if (_formKey.currentState!.validate()) {
      //               context.read<AuthenticationService>().signIn(
      //                   email: emailController.text,
      //                   password: passController.text);
      //             }
      //           },
      //           label: const Text(
      //             'Login',
      //             style: TextStyle(color: Colors.white, fontSize: 20),
      //           ),
      //         ),
      //       ]),
      //     ),
      //   ),
      // ),
    );
  }
}
