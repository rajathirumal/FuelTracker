import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/src/pages/add_fuel_page.dart';
import 'package:fuel_tracker/src/pages/analytics.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fuel_tracker/src/helpers/extension.dart';

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
          title: FittedBox(
            child: Text(
              "Welcome " +
                  FirebaseAuth.instance.currentUser!.email
                      .toString()
                      .split('@')
                      .first
                      .inCaps,
            ),
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
                itemBuilder: (context, index) => fuelCard(allFuels, index),
              )
            : const Center(child: CircularProgressIndicator.adaptive()),
        // (allFuels != null)
        //     ? ListView.builder(
        //         itemCount: allFuels.length,
        //         itemBuilder: (context, int index) {
        //           return ListTile(
        //             title: Text(allFuels[index].fueledForPrice.toString()),
        //             leading: Text(allFuels[index].atKm.toString()),
        //             trailing: Text(allFuels[index].dateOfFuel.split(" ")[0]),
        //             onTap: () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => AddFuelPage(allFuels[index]),
        //                 ),
        //               );
        //             },
        //           );
        //         },
        //       )
        //     : const Center(child: CircularProgressIndicator.adaptive()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Analytics()),
                );
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: Row(
                //     children: const [
                //       Text(
                //         "Please wait while fetchinf data",
                //         style: TextStyle(fontSize: 15),
                //       ),
                //       SizedBox(
                //         width: 20,
                //       ),
                //       CircularProgressIndicator(
                //         color: Colors.amber,
                //         backgroundColor: Colors.white,
                //         strokeWidth: 2,
                //       ),
                //     ],
                //   ),
                //   action: SnackBarAction(
                //     label: "ok",
                //     onPressed: () {},
                //   ),
                //   duration: const Duration(seconds: 2),
                // ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget fuelCard(List<FuelData> fuel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8.0,
        color: Colors.purple[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row 1
              Row(
                children: [
                  const Text("Fuel Date:"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(fuel[index].dateOfFuel.split(" ")[0].toString()),
                  const Spacer(),
                  const Text("Spet: "),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(fuel[index].fueledForPrice.toString() + " ₹"),
                ],
              ),
              const Divider(
                thickness: 0.5,
                color: Colors.blueGrey,
              ),
              // Row 2
              Row(
                children: [
                  const Text("Oodometer:"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(fuel[index].atKm.toString()),
                  const Spacer(),
                  const Text("Market price:"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(fuel[index].marketpricePerLiter.toString() + " ₹"),
                ],
              ),
              const Divider(
                thickness: 0.5,
                color: Colors.blueGrey,
              ),
              // Row 3
              Row(
                children: [
                  const Text("Remaining"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(fuel[index].remainingKM.toString() + " Km"),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFuelPage(fuel[index]),
                        ),
                      );
                    },
                    child: Row(children: const [
                      Icon(Icons.edit, color: Colors.black54),
                    ]),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
