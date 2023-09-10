// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nftgallery/Screens/ContractDeployPage/deployContract.dart';
import 'package:nftgallery/Screens/DeployedContracts/deployedContract.dart';
import 'package:nftgallery/Screens/MintPage/mintPage.dart';
import 'package:nftgallery/Screens/NFTDetailedPage/nftDetailedPage.dart';

import '../../Components/Containers/homeComponents.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final _tabList = [
    {
      'Page': deployContract(),
      Icon: Icon(Icons.settings),
      'title': 'Deploy Contracts'
    },
    {'Page': mintPage(), Icon: Icon(Icons.settings), 'title': 'Mint NFT'},
    {
      'Page': deployedContract(),
      Icon: Icon(Icons.settings),
      'title': 'Transactions'
    },
    // {'Page': nftDetailedScreen(), Icon: Icon(Icons.settings), 'title': 'Mints'},
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _tabList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: containers(
                    title: _tabList[index]['title'] as String,
                    icons: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 60,
                    ),
                    fun: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              _tabList[index]['Page'] as Widget));
                    }),
              );
            }));
    // );
  }
}
