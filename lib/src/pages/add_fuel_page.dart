import 'package:fuel_tracker/provider/fuelService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFuelPage extends StatefulWidget {
  const AddFuelPage({Key? key}) : super(key: key);

  @override
  State<AddFuelPage> createState() => _AddFuelPageState();
}

class _AddFuelPageState extends State<AddFuelPage> {
  @override
  Widget build(BuildContext context) {
    final fuelProvider = Provider.of<FuelProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ADD FUEL",
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(hintText: "Fueled for (Rs)"),
              keyboardType: TextInputType.number,
              onChanged: (value) => fuelProvider.changeFuelForPrice(value),
            ),
            TextField(
              decoration:
                  const InputDecoration(hintText: "Market price (Rs/liter)"),
              keyboardType: TextInputType.number,
              onChanged: (value) => fuelProvider.changemarketPrice(value),
            ),
            TextField(
              decoration: const InputDecoration(hintText: "At Km (Km)"),
              keyboardType: TextInputType.number,
              onChanged: (value) => fuelProvider.changeAtKm(value),
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Remaining KM (Km)"),
              keyboardType: TextInputType.number,
              onChanged: (value) => fuelProvider.changeRemainingKm(value),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  fuelProvider.saveFuelToFireStore();
                  Navigator.pop(context);
                },
                child: const Text("Save")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => fuelProvider.removeFuelFromFireStore(),
                child: const Text("Delete")),
          ],
        ),
      ),
    );
  }
}
