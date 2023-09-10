// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nftgallery/NFT/API/constant/constant.dart';
import 'package:nftgallery/NFT/API/nftDetails.dart';
import 'package:nftgallery/NFT/Models/NFTs.dart';

Future<List<NFTs>> fetchNFTs() async {
  final url = Uri.parse(
      'https://api.verbwire.com/v1/nft/data/created?walletAddress=0x011f77017E0E02739489C629f7473671DFdF2464&chain=goerli&sortDirection=ASC&limit=1000&page=1');
  final headers = {
    'X-API-Key': key,
    'accept': 'application/json',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final jsonMap = json.decode(response.body);

    final nft = List<Map<String, dynamic>>.from(jsonMap['nfts']);
    final nftTransactions = nft.map((e) => NFTs.fromJson(e)).toList();

    print('obj: ${nftTransactions}');
    return nftTransactions;
  } else {
    // Request failed, handle the error here
    print('Request failed with status code: ${response.statusCode}');
    throw Exception('Failed to fetch transaction');
  }
}
