// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nftgallery/Components/AppBar.dart';
import 'package:nftgallery/NFT/API/getNFTs.dart';
import 'package:nftgallery/NFT/API/nftDetails.dart';
import 'package:nftgallery/NFT/Models/NFTs.dart';
import 'package:nftgallery/Screens/NFTDetailedPage/nftDetailedPage.dart';

import '../../NFT/API/getContracts.dart';
import '../../NFT/Models/Transaction.dart';

class mintedScreen extends StatelessWidget {
  const mintedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(6, 3, 34, 0.612),
        appBar: appBar(),
        body: FutureBuilder<List<NFTs>>(
          future: fetchNFTs(),
          builder: (BuildContext context, AsyncSnapshot<List<NFTs>> snapshot) {
            if (snapshot.hasData) {
              final contractList = snapshot.data;
              print('object: ${contractList}');
              return SingleChildScrollView(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: contractList!.length,
                    itemBuilder: (context, index) {
                      final nftData = contractList[index];
                      return Padding(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 2, bottom: 6),
                          child: nftContainer(context, nftData.contractAdd,
                              nftData.tokenId, nftData.tokenName));
                    }),
              );
            } else if (snapshot.hasError) {
              return Text('result: ${snapshot.error.toString()}');
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  InkWell nftContainer(BuildContext ctx, String ctxad, String id, String name) {
    return InkWell(
      onTap: () {
        Navigator.of(ctx)
            .push(MaterialPageRoute(builder: (ctx) => nftDetailedScreen()));
      },
      child: Container(
        padding: EdgeInsets.all(4),
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text('Token ID: ${id}',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  Text('Address:',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Container(
                    width: 271,
                    child: Text(
                      ctxad,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
