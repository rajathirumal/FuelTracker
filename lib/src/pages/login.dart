import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';
import 'package:fuel_tracker/src/helpers/extension.dart';
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
  bool loginError = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  "Welcome Back,",
                  style: TextStyle(fontSize: 35.0),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sign in to continue",
                  style: TextStyle(fontSize: 25.0),
                ),
                const SizedBox(height: 30),
                Visibility(
                  visible: loginError,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline_outlined,
                                size: 40,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(width: 20.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Invalid user:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Kindly Check you creadentials ...",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              hintText: "Email",
                              hintStyle:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.emailRegex) {
                                return 'Enter valid email.(Example: user@domain.com)';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            enableSuggestions: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            controller: passController,
                            decoration: InputDecoration(
                              label: Text("Password"),
                              hintText: "Password",
                              hintStyle:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              prefixIcon: Icon(Icons.password_sharp),
                              suffix: GestureDetector(
                                onTap: () {},
                                child: Icon(Icons.visibility_off),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter password';
                              } else if (value.length < 6) {
                                return "Password should be atlest 6 charecters";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(20)),
                          icon: const Icon(Icons.login, color: Colors.white),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<AuthenticationService>()
                                  .signIn(
                                    email: emailController.text,
                                    password: passController.text,
                                  )
                                  .then((value) {
                                if (value != "signed in") {
                                  _formKey.currentState!.reset();
                                  setState(() async {
                                    setState(() {
                                      loginError = true;
                                    });
                                    await Future.delayed(
                                        const Duration(seconds: 3), () {
                                      setState(() {
                                        loginError = false;
                                      });
                                    });
                                  });
                                }
                              });
                            }
                          },
                          label: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
        ),
      ),
    );
  }
}
