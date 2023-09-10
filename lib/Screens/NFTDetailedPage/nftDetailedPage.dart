// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:nftgallery/Components/AppBar.dart';
import 'package:nftgallery/NFT/API/getNFTs.dart';
import 'package:nftgallery/NFT/API/nftDetails.dart';
import 'package:nftgallery/NFT/Models/NFTs.dart';
import 'package:nftgallery/Screens/NFTDetailedPage/nftBurnAGift.dart';
import '../../NFT/Models/NFTDetails.dart';
import '../MarketPlace/NFTAtMarket.dart';

class nftDetailedScreen extends StatefulWidget {
  const nftDetailedScreen({Key? key});

  @override
  State<nftDetailedScreen> createState() => _nftDetailedScreenState();
}

class _nftDetailedScreenState extends State<nftDetailedScreen> {
  @override
  void initState() {
    fetchNFTs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 3, 34, 0.612),
      appBar: appBar(),
      body: FutureBuilder<List<NFTs>>(
        future: fetchNFTs(),
        builder: (BuildContext context, AsyncSnapshot<List<NFTs>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error.toString()}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            final contractList = snapshot.data;
            return SingleChildScrollView(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //
                  childAspectRatio: 0.75,
                ),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: contractList!.length,
                itemBuilder: (context, index) {
                  final nftData = contractList[index];
                  return FutureBuilder<NFTDetails>(
                    future: fetchNFTDetails(
                      nftData.contractAdd,
                      nftData.tokenId,
                    ),
                    builder: (BuildContext context,
                        AsyncSnapshot<NFTDetails> detailsSnapshot) {
                      if (detailsSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (detailsSnapshot.hasError) {
                        return Center(
                          child: Text(detailsSnapshot.error.toString(),
                              style: TextStyle(color: Colors.white)),
                        );
                      } else if (!detailsSnapshot.hasData) {
                        return Text('No NFT details available.');
                      } else {
                        final nftDetails = detailsSnapshot.data;
                        final metadata = nftDetails!.metadata;
                        print('objectdbhedbhedb: ${nftData.tokenId}');

                        return mintContainer(
                          metadata: metadata,
                          ctxadd: nftData.contractAdd,
                          name: nftDetails.name,
                          symbol: 'goerli',
                          token: nftData.tokenId,
                          buy: true,
                        );
                      }
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class mintContainer extends StatelessWidget {
  const mintContainer({
    super.key,
    required this.metadata,
    required this.ctxadd,
    required this.name,
    required this.symbol,
    required this.token,
    required this.buy,
  });

  final Map<String, dynamic> metadata;
  final String ctxadd;
  final String symbol;
  final String name;
  final String token;
  final bool buy;
  String manupulate() {
    final org = metadata['image'].toString();
    final remove = org.replaceAll('ipfs://', 'https://ipfs.io/ipfs/');
    return remove;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(symbol);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => nftBurnAGirt(
            imgurl: manupulate(),
            contactAdress: ctxadd,
            name: name,
            chain: symbol,
            description: '',
            token: token,
            buy: buy,
          ),
        ));
      },
      child: Container(
        width: 160,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.white),
        ),
        margin: EdgeInsets.all(10),
        child: Center(child: Image.network(manupulate())),
      ),
    );
  }
}
