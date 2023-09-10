import 'dart:convert';
import 'constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:nftgallery/NFT/Models/Transaction.dart';

Future<List<Transaction>> fetchContract() async {
  final url = Uri.parse(
      'https://api.verbwire.com/v1/nft/data/transactions?walletAddress=${Wallet}&chain=goerli&sortDirection=ASC&limit=1000&page=1');

  final response = await http.get(
    url,
    headers: {
      'X-API-Key': key,
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    // final nftTransactions =
    //     List<Map<String, dynamic>>.from(jsonResponse['nft_transactions']);
    // final transactions = nftTransactions
    //     .map((transactionJson) => Transaction.fromJson(transactionJson))
    //     .toList();

    // print('object: ${transactions}');

    // // Process the extracted data
    // for (var transaction in transactions) {
    //   print('Token Name: ${transaction.blockNumber}');
    //   // Add more fields as needed
    // }
    // Map<String, dynamic> transactions = jsonDecode(response.body);

    // List<dynamic> contracts = transactions['nft_transactions'];
    // print(contracts);
    // return contracts;
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
