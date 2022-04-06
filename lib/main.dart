import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication.dart';
import 'package:fuel_tracker/provider/fuelProvider.dart';
import 'package:fuel_tracker/services/firebaseServices.dart';
import 'package:fuel_tracker/src/home/home.dart';
import 'package:fuel_tracker/src/home/login.dart';
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
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.purple[50],
          appBarTheme: AppBarTheme(
            backgroundColor: MyAppThemeProperties().backGroundColor,
            titleTextStyle: MyAppThemeProperties().titleTextColor,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          popupMenuTheme: PopupMenuThemeData(
            color: MyAppThemeProperties().backGroundColor,
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            elevation: 20,
          ),
          dividerColor: Colors.blueGrey,
          primarySwatch: MyAppThemeProperties().actionColor,
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
