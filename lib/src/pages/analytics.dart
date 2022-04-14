import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/services/analysis_service.dart';
import 'package:google_fonts/google_fonts.dart';
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
        // backgroundColor: Colors.red,
        elevation: 0,
        title: FittedBox(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'Horizon',
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(milliseconds: 1500),
              displayFullTextOnTap: true,
              animatedTexts: [
                TyperAnimatedText(
                  'வரவேற்பு',
                  textStyle:
                      const TextStyle(color: Color.fromARGB(255, 0, 160, 29)),
                ),
                TyperAnimatedText('स्वागत'),
                TyperAnimatedText('ಸ್ವಾಗತ'),
                TyperAnimatedText('Welcome'),
                TyperAnimatedText('స్వాగతం'),
                TyperAnimatedText('സ്വാഗതം'),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: welcomeBanner(),
            ),
            const SizedBox(height: 30),
            Center(
              child: FutureBuilder(
                future:
                    AnalysisService.calculateAndGetCurrentSnapshot(allFuels),
                builder:
                    (BuildContext context, AsyncSnapshot analysisSnapshot) {
                  if (analysisSnapshot.hasData) {
                    return analysisBoadr(analysisSnapshot);
                    //Text(analysisSnapshot.data["refuelCount"].toString());
                  }
                  if (analysisSnapshot.hasError) {
                    return Center(
                      child: Text(analysisSnapshot.error.toString()),
                    );
                  } else {
                    return const CircularProgressIndicator.adaptive();
                  }
                },
              ),
              // Text(data1.get("refuelCount").toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget welcomeBanner() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SafeArea(
        child: SizedBox(
          child: Text(
            "All you'r expenditure at one place ...",
            style: GoogleFonts.montserrat(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget analysisBoadr(analysisSnapshot) {
    // return Text(analysisSnapshot.data["couldHaveSaved"].toString());
    return Column(
      children: [
        ListTile(
          title: Text(analysisSnapshot.data["lastUpdate"].toString()),
        ),
        ListTile(
          title: Text(analysisSnapshot.data["couldHaveSaved"].toString()),
        ),
        ListTile(
          title: Text(analysisSnapshot.data["refuelCount"].toString()),
        ),
        ListTile(
          title: Text(analysisSnapshot.data["totalMoneySpent"].toString()),
        ),
      ],
    );
  }
}

/*
          Text(analysisSnapshot.data["lastUpdate"].toString()),
          Text(analysisSnapshot.data["couldHaveSaved"].toString()),
          Text(analysisSnapshot.data["refuelCount"].toString()),
          Text(analysisSnapshot.data["totalMoneySpent"].toString()),

 */
