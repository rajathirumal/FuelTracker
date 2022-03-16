import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_tracker/src/pages/add_fuel_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.list_view,
          overlayOpacity: 0.4,
          spacing: 12,
          spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.add),
              label: "Add new fuel",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFuelPage()));
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: const Text(
                //     "Addind fuel",
                //     style: TextStyle(fontSize: 15),
                //   ),
                //   action: SnackBarAction(
                //     label: "ok",
                //     onPressed: () {},
                //   ),
                //   duration: const Duration(seconds: 2),
                // ));
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.analytics_outlined),
              label: "Add new fuel",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                    children: const [
                      Text(
                        "Please wait while fetchinf data",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircularProgressIndicator(
                        color: Colors.amber,
                        backgroundColor: Colors.white,
                        strokeWidth: 2,
                      ),
                    ],
                  ),
                  action: SnackBarAction(
                    label: "ok",
                    onPressed: () {},
                  ),
                  duration: const Duration(seconds: 2),
                ));
              },
            ),
          ],
        ),

        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(
        //     Icons.add,
        //     color: Colors.red,
        //     size: 40,
        //   ),
        //   onPressed: () {},
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
