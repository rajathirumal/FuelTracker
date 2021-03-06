import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';
import 'package:fuel_tracker/provider/fuel_provider.dart';
import 'package:fuel_tracker/services/firebaseServices.dart';
import 'package:fuel_tracker/src/pages/home.dart';
import 'package:fuel_tracker/src/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:fuel_tracker/src/helpers/project.properties.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireStoreService = FireStoreService();
    return MultiProvider(
      providers: [
        // Auth providers
        Provider<AuthenticationService>(
          create: (context) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChange,
          initialData: null,
        ),
        // Add fuel providers
        ChangeNotifierProvider(create: (context) => FuelProvider()),
        StreamProvider(
          create: (context) => fireStoreService.getAllFuelsFromFireStore(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: //ThemeData.dark(),
            // used in home.dart
            ThemeData(
          cardTheme: CardTheme(
            color: Colors.purple[100],
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          popupMenuTheme: PopupMenuThemeData(
            color: MyAppThemeProperties.backGroundColor,
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            elevation: 20,
          ),
          // used in dd_fuel_page.dart
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.normal,
            buttonColor: MyAppThemeProperties.actionColor,
          ),
          // used all over the app
          scaffoldBackgroundColor: Colors.purple[50],
          appBarTheme: AppBarTheme(
            backgroundColor: MyAppThemeProperties.backGroundColor,
            titleTextStyle: MyAppThemeProperties.titleTextColor,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
      
          dividerColor: Colors.blueGrey,
          primarySwatch: MyAppThemeProperties.actionColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User?>();
    if (firebaseuser != null) {
      return const HomePage();
    } else {
      return const LoginScreen();
    }
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final firebaseuser = context.watch<User?>();
//     if (firebaseuser != null) {
//       return HomePage();
//     } else {
//       return LoginScreen();
//     }
//   }
// }
