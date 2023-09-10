import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nftgallery/NFT/API/constant/constant.dart';

import '../Models/NFTDetails.dart';

Future<NFTDetails> fetchNFTDetails(String contractAdd, String token) async {
  final url = Uri.parse(
      'https://api.verbwire.com/v1/nft/data/nftDetails?contractAddress=${contractAdd}&tokenId=${token}&chain=goerli&populateMetadata=true');

  final response = await http.get(
    url,
    headers: {
      'X-API-Key': key,
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final nftDetails = NFTDetails.fromJson(responseData);
    print('nftDetails: ${nftDetails}');
    return nftDetails;
  } else {
    print('Request failed with status: ${response.statusCode}');
    print(response.body);
    throw Exception(response.body);
  }
}
