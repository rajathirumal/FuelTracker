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
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              // The validator receives the text that the user has entered.
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(hintText: "Email"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please valid email.(Example: user@domain.com)';
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              controller: passController,
              decoration: const InputDecoration(hintText: "Password"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
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
        ),
      ),
    );
  }
}
