// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nftgallery/Components/AppBar.dart';
import 'package:nftgallery/Screens/ContractDeployPage/deploy.dart';
import 'package:nftgallery/Screens/HomePage/homePage.dart';

import '../../Components/Containers/homeComponents.dart';

class deployContract extends StatelessWidget {
  const deployContract({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 3, 34, 0.612),
      appBar: appBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: containers(
                title: 'ERC721',
                icons: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 60,
                ),
                fun: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => deploy()));
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: containers(
                title: 'Other options',
                icons: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 60,
                ),
                fun: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => deploy()));
                }),
          ),
        ],
      ),
    );
  }
}
