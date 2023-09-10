// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nftgallery/NFT/API/giftNFTs.dart';

import '../../../Components/constants/border.dart';

class CustomGiftNftDialog extends StatelessWidget {
  CustomGiftNftDialog(
      {required this.chain, required this.ctxAd, required this.token});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _cntsender =
      TextEditingController(text: '0x011f77017E0E02739489C629f7473671DFdF2464');
  final TextEditingController _cntreceivers = TextEditingController();
  final String chain;
  final String ctxAd;
  final String token;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      title: Text("Gift NFT token"),
      content: Text("Now you can gift tokens"),
      actions: [
        Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your wallet address' : null,
                  style: TextStyle(color: Colors.black),
                  controller: _cntsender,
                  decoration: InputDecoration(
                      labelText: 'Sender wallet address',
                      labelStyle: TextStyle(color: Colors.grey),
                      errorBorder: border(),
                      focusedBorder: border(),
                      enabledBorder: border()),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter receiver wallet address' : null,
                  style: TextStyle(color: Colors.black),
                  controller: _cntreceivers,
                  decoration: InputDecoration(
                      labelText: 'Receivers wallet address',
                      labelStyle: TextStyle(color: Colors.grey),
                      errorBorder: border(),
                      focusedBorder: border(),
                      enabledBorder: border()),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black87),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      giftNFTs(chain, ctxAd, token, _cntsender.text,
                          _cntreceivers.text);
                      // print(_cntreceivers.text);
                      // print(_cntsender.text);
                      // print(chain);
                      // print(ctxAd);
                      // print(token);
                      // giftNFTs();
                    }
                  },
                  child: Text(
                    'Gift',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
