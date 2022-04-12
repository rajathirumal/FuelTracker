import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/services/analysis_service.dart';
import 'package:fuel_tracker/src/helpers/extension.dart';
import 'package:provider/provider.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final allFuels = Provider.of<List<FuelData>?>(context);

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            "Welcome to analytics " +
                FirebaseAuth.instance.currentUser!.email
                    .toString()
                    .split('@')
                    .first
                    .inCaps,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: AnalysisService.calculate(allFuels),
          builder: (BuildContext context, AsyncSnapshot analysisSnapshot) {
            if (analysisSnapshot.hasData) {
              return analysisBoadr(
                  analysisSnapshot); //Text(analysisSnapshot.data["refuelCount"].toString());
            } else {
              return const CircularProgressIndicator.adaptive();
            }
          },
        ),
        // Text(data1.get("refuelCount").toString()),
      ),
    );
  }

  Widget analysisBoadr(analysisSnapshot) {
    return Text(analysisSnapshot.data["couldHaveSaved"].toString());
  }
}
