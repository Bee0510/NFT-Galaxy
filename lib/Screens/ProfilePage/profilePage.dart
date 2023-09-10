// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nftgallery/Firestore/Database.dart';
import 'package:nftgallery/Firestore/models/nftModel.dart';
import 'package:nftgallery/Screens/MarketPlace/marketPlace.dart';
import 'package:provider/provider.dart';

import '../../Auth/Auth Models/auth_class.dart';
import '../../NFT/API/getNFTs.dart';
import '../../NFT/API/nftDetails.dart';
import '../../NFT/Models/NFTDetails.dart';
import '../../NFT/Models/NFTs.dart';
import '../NFTDetailedPage/nftDetailedPage.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  int _selectedTabIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<Users>(context);

    return StreamBuilder<List<nftStore>?>(
      stream: DatabaseService(uid: uid.uid).nfts,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final nfts = snapshot.data ?? [];

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color.fromRGBO(6, 3, 34, 0.612),
          body: Column(
            children: [
              Hero(
                tag: 'profileImage',
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(8),
                  child: Image.network(
                    'https://edgehillcapetown.files.wordpress.com/2016/06/profilepic.jpg?w=778',
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                ),
              ),
              BottomNavigationBar(
                currentIndex: _selectedTabIndex,
                backgroundColor: Color.fromRGBO(9, 5, 49, 0.612),
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.white,
                onTap: _onTabTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Owned NFTs',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Created NFTs',
                  ),
                ],
              ),
              if (_selectedTabIndex == 0)
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: profileNFTTab(nfts),
                  ),
                )
              else if (_selectedTabIndex == 1)
                Expanded(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: FutureBuilder<List<NFTs>>(
                    future: fetchNFTs(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<NFTs>> snapshot) {
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (detailsSnapshot.hasError) {
                                    return Center(
                                      child: Text(
                                          detailsSnapshot.error.toString(),
                                          style:
                                              TextStyle(color: Colors.white)),
                                    );
                                  } else if (!detailsSnapshot.hasData) {
                                    return Text('No NFT details available.');
                                  } else {
                                    final nftDetails = detailsSnapshot.data;
                                    final metadata = nftDetails!.metadata;
                                    print(
                                        'objectdbhedbhedb: ${nftData.tokenId}');

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
                )),
            ],
          ),
        );
      },
    );
  }
}

class profileNFTTab extends StatelessWidget {
  final List<nftStore> nfts;

  const profileNFTTab(this.nfts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: nfts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final nftDetails = nfts[index];
            return MintContainer(
              imageUrl: nftDetails.imgurl,
              contactAddress: nftDetails.contactAdress,
              name: nftDetails.name,
              chain: nftDetails.chain,
              des: nftDetails.description,
              show: false,
            );
          },
        ),
      ],
    );
  }
}
