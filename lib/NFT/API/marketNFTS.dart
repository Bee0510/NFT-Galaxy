// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nftgallery/NFT/API/constant/constant.dart';
import 'package:nftgallery/NFT/Models/Market.dart';
import '../../Components/SearchBar.dart';

Future<List<MarketNFTs>> fetchMarketData() async {
  final url = Uri.parse(
    'https://api.verbwire.com/v1/nft/data/collections/search?searchString=${Searchbar.searchcontroller.text}&chain=ethereum&limit=100&page=1&sortField=rank&sortInterval=allTime&sortDirection=ASC',
  );

  final response = await http.get(
    url,
    headers: {
      'X-API-Key': key,
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data =
        json.decode(response.body)['collections']['results'];

    final List<MarketNFTs> marketNFTsList =
        data.map((item) => MarketNFTs.fromJson(item)).toList();
    print(marketNFTsList);
    return marketNFTsList;
  } else {
    print('Request failed with status: ${response.statusCode}');
    throw Exception('Eroor error r');
  }
}
