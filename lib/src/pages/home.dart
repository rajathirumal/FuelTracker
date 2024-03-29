import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/src/pages/add_fuel_page.dart';
import 'package:fuel_tracker/src/pages/analytics.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';
import 'package:fuel_tracker/src/helpers/extension.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum MenuOptions {
  analytics,
  logout,
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final allFuels = Provider.of<List<FuelData>?>(context);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            "Welcome ${FirebaseAuth.instance.currentUser!.email.toString().split('@').first.inCaps}",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddFuelPage())),
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          PopupMenuButton<MenuOptions>(
            onSelected: (value) {
              switch (value) {
                case MenuOptions.analytics:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Analytics()));
                  break;
                case MenuOptions.logout:
                  context.read<AuthenticationService>().signOut();
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<MenuOptions>>[
                PopupMenuItem(
                  value: MenuOptions.analytics,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.analytics_outlined,
                        color: Colors.black,
                      ),
                      Text("Analysis"),
                    ],
                  ),
                ),
                const PopupMenuDivider(height: 1),
                PopupMenuItem(
                  value: MenuOptions.logout,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      Text("Logout"),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: (allFuels != null)
          ? (allFuels.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No data to show",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Try adding fuels from + button on top",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                )
              : OrientationBuilder(
                  builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: allFuels.length,
                        itemBuilder: (context, index) =>
                            fuelCard(allFuels, index),
                        addAutomaticKeepAlives: false,
                      );
                    } else {
                      return Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: allFuels.length,
                              itemBuilder: (context, index) => (index % 2 == 0)
                                  ? fuelCard(allFuels, index)
                                  : const SizedBox(),
                              addAutomaticKeepAlives: false,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: allFuels.length,
                              itemBuilder: (context, index) => (index % 2 != 0)
                                  ? fuelCard(allFuels, index)
                                  : const SizedBox(),
                              addAutomaticKeepAlives: false,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                )
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget fuelCard(List<FuelData> fuel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFuelPage(fuel[index]),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Row 1
                Row(
                  children: [
                    const Text(
                      "Fuel Date:",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      fuel[index].dateOfFuel.split(" ")[0].toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    const Text(
                      "Spet:",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      fuel[index].fueledForPrice.toString() + " ₹",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                ),
                // Row 2
                Row(
                  children: [
                    const Text(
                      "Oodometer:",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      fuel[index].atKm.toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    const Text(
                      "Market price:",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      fuel[index].marketpricePerLiter.toString() + " ₹",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                ),
                // Row 3
                Row(
                  children: [
                    const Text(
                      "Remaining",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      fuel[index].remainingKM.toString() + " Km",
                      style: const TextStyle(fontSize: 15),
                    ),
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
                      child: Row(
                        children: const [
                          Icon(Icons.edit, color: Colors.purple),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
