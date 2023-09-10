import 'package:http/http.dart' as http;
import 'package:nftgallery/NFT/API/constant/constant.dart';

void giftNFTs(String chain, String ctxAd, String token, String senAd,
    String recAd) async {
  var url = Uri.parse('https://api.verbwire.com/v1/nft/update/transferToken');
  var headers = {
    'X-API-Key': key,
    'accept': 'application/json',
  };

  var request = http.MultipartRequest('POST', url);
  request.headers.addAll(headers);
  request.fields['chain'] = chain;
  request.fields['contractAddress'] = ctxAd;
  request.fields['tokenId'] = token;
  request.fields['fromAddress'] = senAd;
  request.fields['toAddress'] = recAd;

  var response = await request.send();
  print('Response Body: ${await response.stream.bytesToString()}');
  print('Response Headers: ${response.headers}');

  if (response.statusCode == 200) {
    print('Request successful');
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
