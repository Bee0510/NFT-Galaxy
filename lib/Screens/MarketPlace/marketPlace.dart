// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nftgallery/Components/SearchBar.dart';
import 'package:nftgallery/NFT/API/marketNFTS.dart';
import 'package:nftgallery/NFT/Models/Market.dart';
import 'package:nftgallery/Screens/MarketPlace/NFTAtMarket.dart';

class marketPlace extends StatefulWidget {
  const marketPlace({super.key});

  @override
  State<marketPlace> createState() => _marketPlaceState();
}

class _marketPlaceState extends State<marketPlace> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Searchbar(onSearchPressed: () {
              setState(() {
                fetchMarketData();
              });
            }),
            FutureBuilder<List<MarketNFTs>>(
              initialData: null,
              future: fetchMarketData(),
              builder: (context, AsyncSnapshot<List<MarketNFTs>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString(),
                        style: TextStyle(color: Colors.white)),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                      child: Text(
                    'No NFT details available.',
                    style: TextStyle(color: Colors.white),
                  ));
                } else {
                  final nftDetailsList = snapshot.data;

                  return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: nftDetailsList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, //
                        childAspectRatio: 0.75,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final nftDetails = nftDetailsList[index];
                        return MintContainer(
                          imageUrl: nftDetails.image,
                          contactAddress: nftDetails.primarycnt,
                          name: nftDetails.twitter,
                          chain: nftDetails.chain,
                          des: nftDetails.description,
                          show: false,
                        );
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MintContainer extends StatelessWidget {
  final String imageUrl;
  final String contactAddress;
  final String name;
  final String chain;
  final String des;
  final bool show;
  const MintContainer(
      {super.key,
      required this.imageUrl,
      required this.contactAddress,
      required this.name,
      required this.chain,
      required this.des,
      required this.show});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => nftAtMarket(
                imgurl: imageUrl,
                contactAdress: contactAddress,
                chain: chain,
                name: name,
                description: des)));
      },
      child: Container(
        width: 160,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.white),
        ),
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                top: 0,
                child: Hero(
                  tag: 'NFT',
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image(image: imageProvider, fit: BoxFit.cover),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 3,
                right: 3,
                child: SizedBox(
                  width: 150,
                  child: show
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => nftAtMarket(
                                  imgurl: imageUrl,
                                  contactAdress: contactAddress,
                                  name: name,
                                  chain: chain,
                                  description: des,
                                ),
                              ),
                            );
                          },
                          child: Text('Buy now'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black87),
                          ),
                        )
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
