import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';
import 'package:fuel_tracker/src/home/home.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
            controller: emailController,
          ),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
            controller: passController,
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                          email: emailController.text,
                          password: passController.text.trim(),
                        );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: const Text("Login")),
              // ElevatedButton(
              //   onPressed: () {
              //     context.read<AuthenticationService>().signUp(
              //           email: emailController.text,
              //           password: passController.text.trim(),
              //         );
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => HomePage(),
              //       ),
              //     );
              //   },
              //   child: const Text("SignUp"),
              // )
            ],
          ),
        ]),
      ),
    );
  }
}
