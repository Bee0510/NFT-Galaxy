// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

AppBar appBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Color.fromRGBO(21, 21, 21, 100),
    title: Text('NFT Galaxy'),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(
              'https://edgehillcapetown.files.wordpress.com/2016/06/profilepic.jpg?w=778',
            ),
          ),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[Icon(Icons.home), Text('100.4567')],
            ),
          ),
        ),
      ),
    ],
  );
}
