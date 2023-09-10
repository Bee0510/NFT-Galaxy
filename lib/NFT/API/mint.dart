import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nftgallery/NFT/API/constant/constant.dart';

// Future<void> mintNFT() async {
//   final url = Uri.parse('https://api.verbwire.com/v1/nft/mint/mintFromFile');
//   final headers = {
//     'X-API-Key': 'sk_live_95dc07d8-893f-49ee-bef9-c46135d41a9f',
//     'accept': 'application/json',
//   };

//   final request = http.MultipartRequest('POST', url)
//     ..headers.addAll(headers)
//     ..fields['allowPlatformToOperateToken'] = 'true'
//     ..fields['quantity'] = '1'
//     ..fields['chain'] = 'goerli'
//     ..fields['contractAddress'] = '0x9abd1062868a16E6Ac66bEdcC157Aa89F9470113'
//     ..fields['description'] = 'Test3'
//     ..fields['name'] = 'Testing3';

// final imageBytes = await rootBundle.load('assets/lionlogo.png');
// final imageFile = http.MultipartFile.fromBytes(
//   'filePath',
//   imageBytes.buffer.asUint8List(),
//   filename: 'lionlogo.png',
//   contentType: MediaType('image', 'png'),
// );

//   request.files.add(imageFile);

//   final response = await request.send();
//   if (response.statusCode == 200) {
//     // Successful minting logic
//     print('NFT Minted successfully.');
//   } else {
//     // Error handling logic
//     print('Failed to mint NFT. Status code: ${response.statusCode}');
//   }
// }

Future<void> mintNFT(String img, String name, String des, String chain,
    String cadress, String waddress, String quan) async {
  final url = Uri.parse('https://api.verbwire.com/v1/nft/mint/mintFromFile');

  // Create a MultipartRequest and set headers
  final request = http.MultipartRequest('POST', url);
  request.headers['X-API-Key'] = key;
  request.headers['accept'] = 'application/json';

  // Add form fields
  request.fields['allowPlatformToOperateToken'] = 'true';
  request.fields['quantity'] = quan;
  request.fields['chain'] = chain;
  request.fields['name'] = name;
  request.fields['description'] = des;
  request.fields['recipientAddress'] = waddress;
  request.fields['contractAddress'] = cadress;

  // Add file
  final File file = File(img);
  final stream = http.ByteStream(file.openRead());
  final length = await file.length();
  final multipartFile = http.MultipartFile('filePath', stream, length,
      filename: file.path.split('/').last,
      contentType: MediaType('image', 'jpeg'));
  request.files.add(multipartFile);

  // Send the request and handle the response
  final response = await request.send();
  final responseBody = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(responseBody);
    final transactionHash = jsonResponse['transactionHash'];

    // Show the transaction hash in a pop-up
    Fluttertoast.showToast(
      // msg: 'Transaction Hash: $transactionHash',
      msg: 'NFT Minted successfully. ',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
    print('Response: $jsonResponse');
  } else {
    print('Request failed with status: ${response.statusCode}');
    print('Response body: $responseBody');
  }
}
