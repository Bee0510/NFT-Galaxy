// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nftgallery/Components/AppBar.dart';
import 'package:nftgallery/NFT/API/getContracts.dart';
import 'package:nftgallery/NFT/Models/Transaction.dart';

class deployedContract extends StatelessWidget {
  const deployedContract({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 3, 34, 0.612),
      appBar: appBar(),
      body: FutureBuilder<List<Transaction>>(
        future: fetchContract(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
          if (snapshot.hasData) {
            final contractList = snapshot.data;
            print('object: ${contractList}');
            return SingleChildScrollView(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contractList!.length,
                  itemBuilder: (context, index) {
                    final contractData = contractList[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 2, bottom: 6),
                      child: contractContainer(
                          contractData.hash,
                          contractData.from,
                          contractData.tokenName,
                          contractData.tokenSymbol),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text('result: ${snapshot.error.toString()}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  InkWell contractContainer(
      String address, String from, String name, String symbol) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(4),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://azcoinnews.com/wp-content/uploads/2019/12/Ethereum-Istanbul.jpg'),
                ),
                SizedBox(width: 160),
                Column(
                  children: <Widget>[
                    Text(name,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        overflow: TextOverflow.ellipsis),
                    Text(symbol,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        overflow: TextOverflow.ellipsis),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'from: ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        from,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'to:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        address,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
