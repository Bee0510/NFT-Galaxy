// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:nftgallery/Auth/Athentication%20Pages/SignInpage.dart';
import 'package:nftgallery/Components/Navbar.dart';
import 'package:provider/provider.dart';

import '../Auth Models/auth_class.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    if (user == null) {
      return SignIN();
    } else {
      return navBar();
    }
  }
}
