import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nftgallery/NFT/API/constant/constant.dart';
import 'package:nftgallery/NFT/Models/Transaction.dart';

Future<List<Transaction>> fetchContract() async {
  final url = Uri.parse(
      'https://api.verbwire.com/v1/nft/data/transactions?walletAddress=0x011f77017E0E02739489C629f7473671DFdF2464&chain=goerli&sortDirection=ASC&limit=1000&page=1');

  final response = await http.get(
    url,
    headers: {
      'X-API-Key': key,
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final nftTransactions =
        List<Map<String, dynamic>>.from(jsonResponse['nft_transactions']);
    final transactions =
        nftTransactions.map((e) => Transaction.fromJson(e)).toList();
    return transactions;
  } else {
    print('Request failed with status: ${response.statusCode}');
    throw Exception('Failed to fetch transaction');
  }
}
