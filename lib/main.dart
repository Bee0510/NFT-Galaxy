// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nftgallery/Auth/Athentication%20Pages/wrapper.dart';
import 'package:nftgallery/Auth/Auth%20Models/auth_class.dart';
import 'package:nftgallery/Auth/Auth/Auth.dart';
import 'package:nftgallery/Components/Navbar.dart';
import 'package:nftgallery/Screens/HomePage/homePage.dart';
import 'package:nftgallery/Screens/LoginPage/loginPage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      initialData: null,
      value: Authentication().UserDetails,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
