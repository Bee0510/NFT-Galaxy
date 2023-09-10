// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:walletconnect_dart/walletconnect_dart.dart';
// import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

// class metaPhone extends StatefulWidget {
//   const metaPhone({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<metaPhone> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<metaPhone> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // if (metamask.address != null) Text('address: ${metamask.address}'),
//             // if (metamask.signature != null)
//             //   Text('signed: ${metamask.signature}'),
//             // Text(
//             //   metamask.address == null
//             //       ? 'You are not logged in'
//             //       : 'You are logged in',
//             // ),
//             // Text('Metamask support ${metamask.isSupported}'),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Create a connector
//           final connector = WalletConnect(
//             uri: 'wc:8a5e5bdc-a0e4-47...TJRNmhWJmoxdFo6UDk2WlhaOyQ5N0U=',
//             clientMeta: PeerMeta(
//               name: 'WalletConnect',
//               description: 'WalletConnect Developer App',
//               url: 'https://walletconnect.org',
//               icons: [
//                 'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
//               ],
//             ),
//           );

// // Subscribe to events
//           connector.on('connect', (session) => print(session));
//           connector.on('session_request', (payload) => print(payload));
//           connector.on('disconnect', (session) => print(session));
//         },
//         tooltip: 'Login',
//         child: const Icon(Icons.login),
//       ),
//     );
//   }
// }

// Future<void> connectMetamask() async {
//   AuthClient authClient = await AuthClient.createInstance(
//     relayUrl: 'wss://relay.walletconnect.com',
//     projectId: '39de7e05326e57ea33a565ec4f67b079',
//     metadata: PairingMetadata(
//       name: 'dapp (Requester)',
//       description: 'A dapp that can request that transactions be signed',
//       url: 'https://walletconnect.com',
//       icons: ['https://avatars.githubusercontent.com/u/37784886'],
//     ),
//   );

//   final AuthRequestResponse auth = await authClient.request(
//     params: AuthRequestParams(
//       aud: 'http://localhost:3000/login',
//       domain: 'localhost:3000',
//       chainId: 'eip155:1',
//       statement: 'Sign in with your wallet!',
//     ),
//   );

//   final uri = auth.uri;
//   final AuthResponse authResponse = await auth
//       .completer.future; // Use auth.completer.future to await the response

//   if (authResponse.result != null) {
//     // Having a result indicates that the signature has been verified.
//     // Retrieve the wallet address from a successful response
//     final walletAddress =
//         AddressUtils.getDidAddress(authResponse.result!.p.iss);
//     print('Wallet Address: $walletAddress');
//   } else {
//     // Handle errors
//     if (authResponse.error != null) {
//       final WalletConnectError? error = authResponse.error;
//       print('WalletConnect Error: ${error?.message}');
//     } else if (authResponse.jsonRpcError != null) {
//       final JsonRpcError? error = authResponse.jsonRpcError;
//       print('JsonRpc Error: ${error?.message}');
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:provider/provider.dart';

class MetaMaskProvider extends ChangeNotifier {
  int currentChain = -1;
  String currentAddress = '';
  static const operatingChain = 4;

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  // connect
  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;

      currentChain = await ethereum!.getChainId();

      notifyListeners();
    }
  }

  // clear data
  void clear() {
    currentAddress = '';
    currentChain = -1;

    notifyListeners();
  }

  void init() {
    /// in both the cases we clear the data and re-sign in the metamask
    if (isEnabled) {
      // whenever the account is changed
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });

      // whenever the chain is change
      ethereum!.onChainChanged((chainId) {
        clear();
      });
    }
  }
}

class metaConnect extends StatelessWidget {
  const metaConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 55.0,
          width: 250.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: MaterialButton(
            child: Consumer<MetaMaskProvider>(
              builder: (context, meta, child) {
                String text = '';
                if (meta.isConnected && meta.isInOperatingChain) {
                  text = 'Metamask connected';
                } else if (meta.isConnected && !meta.isInOperatingChain) {
                  text = 'Wrong operating chain';
                } else if (meta.isEnabled) {
                  return const Text(
                    'Connect Metamask',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  text = 'Unsupported Browser';
                }

                return Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            onPressed: () {
              final meta = context.read<MetaMaskProvider>();
              meta.connect();
            },
          ),
        ),
      ),
    );
  }
}
