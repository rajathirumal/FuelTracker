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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
              backgroundColor: ColorProjectProperty().actionColor,
              titleTextStyle: const TextStyle(color: Colors.white),
              elevation: 5.0),
          primarySwatch: ColorProjectProperty().actionColor,
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
      return HomePage();
    } else {
      return LoginScreen();
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
