import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walaplus_family_mgmt/services/auth_services.dart';
import 'package:walaplus_family_mgmt/ui/home.dart';
import 'package:walaplus_family_mgmt/ui/login.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (_) => context.read<AuthService>().authStateChanges, initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Almarai',
          primarySwatch: Colors.green,
        ),
        //TODO: changer to AuthWrapper
        home: LoginScreen(),
      ),
    );

  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    if(user != null) {
      return HomeScreen();
    }
    return LoginScreen();
  }
}
