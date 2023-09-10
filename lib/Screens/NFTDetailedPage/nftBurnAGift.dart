// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nftgallery/NFT/API/burnNFTs.dart';

import 'Gift/giftPop.dart';

class nftBurnAGirt extends StatefulWidget {
  nftBurnAGirt({
    super.key,
    required this.imgurl,
    required this.contactAdress,
    required this.chain,
    required this.name,
    required this.description,
    required this.token,
    required this.buy,
  });
  final String imgurl;
  final String contactAdress;
  final String chain;
  final String name;
  final String description;
  final String token;
  final bool buy;
  @override
  State<nftBurnAGirt> createState() => _nftBurnAGirtState();
}

class _nftBurnAGirtState extends State<nftBurnAGirt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 3, 34, 0.612),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.white)),
                  height: 400,
                  child: Hero(
                    tag: 'NFT',
                    child: CachedNetworkImage(
                      imageUrl: widget.imgurl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image(image: imageProvider, fit: BoxFit.cover),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: widget.buy
                      ? ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart_checkout,
                          ),
                          label: Text('Buy for 4.560 ETH'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black87),
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart_checkout,
                          ),
                          label: Text('Bought for 4.560 ETH'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black87),
                          ),
                        ),
                ),
              ),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Text(
                    widget.chain,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              )),
              marketPurchasedet('Address: ', widget.contactAdress),
              Container(
                height: 200,
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.description,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  overflow: TextOverflow.clip,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomGiftNftDialog(
                              chain: widget.chain,
                              ctxAd: widget.contactAdress,
                              token: widget.token);
                        },
                      );
                    },
                    child: Text('Gift NFT')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      print(widget.chain);
                      print(widget.token);
                      print(widget.contactAdress);
                      burnNFTs(
                          widget.contactAdress, widget.token, widget.chain);
                    },
                    child: Text('Burn')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding marketPurchasedet(String attri, String value) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Text(
            attri,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          Container(
            width: 280,
            child: Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
