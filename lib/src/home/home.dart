import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (context) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChange,
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Fuel Tracker"),
          actions: [
            IconButton(
              onPressed: () => context.read<AuthenticationService>().signOut(),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Container(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.greenAccent,
          items: const [
            BottomNavigationBarItem(
                label: "abc   lable", icon: Icon(Icons.abc)),
            BottomNavigationBarItem(
                label: "ac unit", icon: Icon(Icons.ac_unit)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.red,
            size: 40,
          ),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
