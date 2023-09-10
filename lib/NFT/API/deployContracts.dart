import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nftgallery/NFT/API/constant/constant.dart';

Future<String?> deployNFTContract(
    String cntname, String cntsymbol, String cnticon, String walladress) async {
  final url =
      Uri.parse('https://api.verbwire.com/v1/nft/deploy/deployContract');

  final response = await http.post(
    url,
    headers: {
      'X-API-Key': key,
      'accept': 'application/json',
    },
    body: {
      'chain': cnticon,
      'contractType': 'nft721',
      'contractCategory': 'simple',
      'isCollectionContract': 'false',
      'contractName': cntname,
      'contractSymbol': cntsymbol,
      'recipientAddress': walladress,
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final transactionDetails = jsonResponse['transaction_details'];
    final contractAddress =
        transactionDetails['createdContractAddress'] as String?;
    print('Contract Address: $contractAddress');
    return contractAddress;
  } else {
    print('Request failed with status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
