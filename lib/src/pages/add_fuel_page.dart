import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/provider/fuelProvider.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/src/helpers/extension.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddFuelPage extends StatefulWidget {
  // const AddFuelPage({Key? key}) : super(key: key);
  final FuelData? fuel;
  const AddFuelPage([this.fuel]);

  @override
  State<AddFuelPage> createState() => _AddFuelPageState();
}

class _AddFuelPageState extends State<AddFuelPage> {
  final fuelForTEC = TextEditingController();
  final marketPriceTEC = TextEditingController();
  final atKmTEC = TextEditingController();
  final remainingKmTEC = TextEditingController();

  @override
  void dispose() {
    fuelForTEC.dispose();
    marketPriceTEC.dispose();
    atKmTEC.dispose();
    remainingKmTEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.fuel == null) {
      fuelForTEC.text = "";
      marketPriceTEC.text = "";
      atKmTEC.text = "";
      remainingKmTEC.text = "";
      super.initState();
    } else {
      fuelForTEC.text = widget.fuel!.fueledForPrice.toString();
      marketPriceTEC.text = widget.fuel!.marketpricePerLiter.toString();
      atKmTEC.text = widget.fuel!.atKm.toString();
      remainingKmTEC.text = widget.fuel!.remainingKM.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fuelProvider = Provider.of<FuelProvider>(context);
    final _fuelFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            "ADD FUEL - " +
                FirebaseAuth.instance.currentUser!.email
                    .toString()
                    .split('@')
                    .first
                    .inCaps,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _fuelFormKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Refueled for"),
                controller: fuelForTEC,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter money spent';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Price per liter"),
                controller: marketPriceTEC,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cost per liter';
                  } else {
                    null;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Refueld at KM"),
                controller: atKmTEC,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current oodometer reading';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Remaining KM"),
                controller: remainingKmTEC,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter remaining KM';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_fuelFormKey.currentState!.validate()) {
                    fuelProvider.saveFuelToFireStore(
                      fuelID: widget.fuel == null
                          ? const Uuid().v1()
                          : widget.fuel!.fuelID,
                      fuelforprice: fuelForTEC.text,
                      marketprice: marketPriceTEC.text,
                      atkms: atKmTEC.text,
                      remainingkms: remainingKmTEC.text,
                      datefueld: widget.fuel == null
                          ? DateTime.now().toString()
                          : widget.fuel!.dateOfFuel,
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Add fuel',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text(
    //       "ADD FUEL",
    //       style: TextStyle(
    //         color: Colors.white70,
    //         fontWeight: FontWeight.bold,
    //         letterSpacing: 3,
    //       ),
    //     ),
    //     centerTitle: true,
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: ListView(
    //       children: <Widget>[
    //         TextField(
    //           controller: fuelForTEC,
    //           decoration: const InputDecoration(hintText: "Fueled for (Rs)"),
    //           keyboardType: TextInputType.number,
    //           onChanged: (value) => fuelProvider.changeFuelForPrice(value),
    //         ),
    //         TextField(
    //           controller: marketPriceTEC,
    //           decoration:
    //               const InputDecoration(hintText: "Market price (Rs/liter)"),
    //           keyboardType: TextInputType.number,
    //           onChanged: (value) => fuelProvider.changemarketPrice(value),
    //         ),
    //         TextField(
    //           controller: atKmTEC,
    //           decoration: const InputDecoration(hintText: "At Km (Km)"),
    //           keyboardType: TextInputType.number,
    //           onChanged: (value) => fuelProvider.changeAtKm(value),
    //         ),
    //         TextField(
    //           controller: remainingKmTEC,
    //           decoration: const InputDecoration(hintText: "Remaining KM (Km)"),
    //           keyboardType: TextInputType.number,
    //           onChanged: (value) => fuelProvider.changeRemainingKm(value),
    //         ),
    //         const SizedBox(height: 10),
    //         ElevatedButton(
    //             onPressed: () {
    //               fuelProvider.saveFuelToFireStore(
    //                 fuelID:
    //                     widget.fuel == null ? Uuid().v1() : widget.fuel!.fuelID,
    //                 fuelforprice: fuelForTEC.text,
    //                 marketprice: marketPriceTEC.text,
    //                 atkms: atKmTEC,
    //                 remainingkms: remainingKmTEC.text,
    //                 daterefueld: widget.fuel == null
    //                     ? DateTime.now().toString()
    //                     : widget.fuel!.dateOfFuel,
    //               );
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text("Save")),
    //         const SizedBox(height: 10),
    //         ElevatedButton(
    //             onPressed: () => fuelProvider.removeFuelFromFireStore(),
    //             child: const Text("Delete")),
    //       ],
    //     ),
    //   ),
    // );
  }
}
