import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zon_gneapp/firebase_options.dart';
import 'package:zon_gneapp/screens/Login.dart';
import 'package:zon_gneapp/firebase_options.dart';


void  main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(zon_gneapp());
}

class zon_gneapp extends StatelessWidget {
  const zon_gneapp( {super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginApp(),
    );
  }
}