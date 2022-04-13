import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/provider/fuel_provider.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/src/helpers/extension.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../provider/fuel_provider.dart';

class AddFuelPage extends StatefulWidget {
  final FuelData? fuel;
  // ignore: use_key_in_widget_constructors
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
            "Add fuel - " +
                FirebaseAuth.instance.currentUser!.email
                    .toString()
                    .split('@')
                    .first
                    .inCaps,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            // padding: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Form(
              key: _fuelFormKey,
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      label: Text("Refueled for"),
                      hintText: "In  ₹",
                      prefixIcon: Icon(Icons.bubble_chart),
                      suffix: Text("₹"),
                      border: OutlineInputBorder(),
                    ),
                    controller: fuelForTEC,
                    keyboardType: TextInputType.number,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter money spent'
                        : (double.parse(value) == 0)
                            ? "Cannot be 0"
                            : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      label: Text("Price per liter"),
                      hintText: "In ₹",
                      prefixIcon: Icon(Icons.attach_money),
                      suffix: Text("₹"),
                      border: OutlineInputBorder(),
                    ),
                    controller: marketPriceTEC,
                    keyboardType: TextInputType.number,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter cost per liter'
                        : double.parse(value) < 50.0
                            ? "Canot be less than 50 ₹"
                            : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      label: Text("Oodometer reading"),
                      hintText: "In KM",
                      prefixIcon: Icon(Icons.speed_sharp),
                      suffix: Text("Km"),
                      border: OutlineInputBorder(),
                    ),
                    controller: atKmTEC,
                    keyboardType: TextInputType.number,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter current oodometer reading'
                        : (double.parse(value) < 100)
                            ? "Cannot be less than 100 KM"
                            : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      label: Text("Remaining"),
                      hintText: "In KM",
                      prefixIcon: Icon(Icons.grain_sharp),
                      suffix: Text("Km"),
                      border: OutlineInputBorder(),
                    ),
                    controller: remainingKmTEC,
                    keyboardType: TextInputType.number,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter remaining KM'
                        : null,
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
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
                        style: TextStyle( fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
        ),
      ),
    );
  }
}
