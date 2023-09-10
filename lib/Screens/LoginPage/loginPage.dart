// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // var connector = WalletConnect(
  //     bridge: 'https://bridge.walletconnect.org',
  //     clientMeta: const PeerMeta(
  //         name: 'My App',
  //         description: 'An app for converting pictures to NFT',
  //         url: 'https://URLwalletconnect.org',
  //         icons: [
  //           'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
  //         ]));

  var _session, _uri;
  final walletNamespaces = {
    'eip155': Namespace(
      accounts: ['eip155:1:abc'],
      methods: ['eth_signTransaction'],
      events: [],
    ),
    'kadena': Namespace(
      accounts: ['kadena:mainnet01:abc'],
      methods: ['kadena_sign_v1', 'kadena_quicksign_v1'],
      events: ['kadena_transaction_updated'],
    ),
  };
  loginUsingMetamask(BuildContext context) async {
    Web3Wallet web3Wallet = await Web3Wallet.createInstance(
      relayUrl:
          'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
      projectId: '39de7e05326e57ea33a565ec4f67b079',
      metadata: PairingMetadata(
        name: 'Wallet (Responder)',
        description: 'A wallet that can be requested to sign transactions',
        url: 'https://walletconnect.com',
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
      ),
    );
    late int id;
    web3Wallet.onSessionProposal.subscribe((args) async {
      id = args!.id;
    });
    final signRequestHandler = (String topic, dynamic parameters) async {
      final parsedResponse = parameters;

      bool userApproved = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sign Transaction'),
            content: SizedBox(
              width: 300,
              height: 350,
              child: Text(parsedResponse.toString()),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Accept'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Reject'),
              ),
            ],
          );
        },
      );

      if (userApproved) {
        return 'Signed!';
      } else {
        throw Errors.getSdkError('error: ${Errors.USER_REJECTED_SIGN}');
      }
    };

    await web3Wallet.approveSession(id: id, namespaces: walletNamespaces);

    // if (!web3Wallet.connected) {
    //   try {
    //     var session = await connector.createSession(onDisplayUri: (uri) async {
    //       _uri = uri;
    //       await launchUrlString(uri, mode: LaunchMode.externalApplication);
    //     });
    //     setState(() {
    //       _session = session;
    //     });
    //   } catch (exp) {
    //     print(exp);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    // connector.on('connect', (session) => print(session));
    // connector.on('session_update', (payload) => print(payload));
    // connector.on('disconnect', (session) => print(session));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/main_page_image.png',
              fit: BoxFit.fitHeight,
            ),
            ElevatedButton(
                onPressed: () async {
                  loginUsingMetamask(context);
                },
                child: const Text("Connect with Metamask"))
          ],
        ),
      ),
    );
  }
}
