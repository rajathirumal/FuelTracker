import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/src/pages/add_fuel_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fuel_tracker/services/extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final allFuels = Provider.of<List<FuelData>?>(context);
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
          title: Text(
            "Welcome " +
                FirebaseAuth.instance.currentUser!.email
                    .toString()
                    .split('@')
                    .first
                    .inCaps,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () => context.read<AuthenticationService>().signOut(),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: (allFuels != null)
            ? ListView.builder(
                itemCount: allFuels.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    title: Text(allFuels[index].fueledForPrice.toString()),
                    leading: Text(allFuels[index].atKm.toString()),
                    trailing: Text(allFuels[index].dateOfFuel.split(" ")[0]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFuelPage(allFuels[index]),
                        ),
                      );
                    },
                  );
                },
              )
            : const Center(child: CircularProgressIndicator.adaptive()),

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
              label: "Analytics",
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
