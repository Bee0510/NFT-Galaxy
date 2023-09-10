import 'package:http/http.dart' as http;
import 'package:nftgallery/NFT/API/constant/constant.dart';

void burnNFTs(String cntad, String token, String chain) async {
  var url = Uri.parse('https://api.verbwire.com/v1/nft/update/burn');
  var headers = {
    'X-API-Key': key,
    'accept': 'application/json',
  };

  var request = http.MultipartRequest('POST', url);
  request.headers.addAll(headers);
  request.fields['chain'] = 'goerli';
  request.fields['contractAddress'] = cntad;
  request.fields['tokenId'] = token;
  request.fields['contractType'] = 'nft721';

  var response = await request.send();
  print('Response Body: ${await response.stream.bytesToString()}');
  print('Response Headers: ${response.headers}');
  if (response.statusCode == 200) {
    print('Request successful');
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
