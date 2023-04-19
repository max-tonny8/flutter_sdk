import 'package:flutter/material.dart';
import 'package:walletconnect_qrcode_modal_dart/walletconnect_qrcode_modal_dart.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart'; //You can also import the browser version
// utf8 import
import 'dart:convert';

Future<void> ethereumProvider(BuildContext context) async {
  var httpClient = Client();

// Create a connector
  final qrCodeModal = WalletConnectQrCodeModal(
    connector: WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        // <-- Meta data of your app appearing in the wallet when connecting
        name: 'MoonGate',
        description: 'MoonGate Developer App',
        url: 'localhost:3000',
        icons: [
          'https://www.joinef.com/wp-content/uploads/2023/03/MoonGate-5-Praneet-Sinha-700x700.png'
        ],
      ),
    ),
  );
  final session = await qrCodeModal.connect(context).catchError((error) {
    print('Error: $error');
    return null;
  });
  // request sign message
  print(session);
  final provider = EthereumWalletConnectProvider(qrCodeModal.connector);
  final ethereum = Web3Client('https://goerli.infura.io/', Client());
  final sender = EthereumAddress.fromHex(session!.accounts[0]);
  // create and sign a message to authenticate the user that says "Hello World"
  final message = "sign this for cookies";
  final signature = await provider.personalSign(
      message: message, address: sender.hex, password: "password");
  print(signature);
}
