import 'package:flutter/material.dart';
import 'package:walletconnect_qrcode_modal_dart/walletconnect_qrcode_modal_dart.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

Future<void> ethereumProvider(BuildContext context) async {
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
  final sender = EthereumAddress.fromHex(session!.accounts[0]);
  // define EIP55 address
  String address = sender.hexEip55;
  // Define variables for the message
  const domain = "localhost";
  const statement = "Hello World";
  const version = "1";
  const uri = "http://localhost:3000";
  const chainId = "1";
  const nonce = "32891756";
  // get the current date time in epoch ISO 8601 format of now up to milliseconds
  DateTime now = DateTime.now();
  int millisecondsSinceEpoch = now.millisecondsSinceEpoch;
  String iso8601 = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)
      .toIso8601String();

  // Remove microseconds from the ISO 8601 string
  int indexOfDot = iso8601.indexOf('.');
  String iso8601WithoutMicroseconds =
      iso8601.substring(0, indexOfDot + 4) + 'Z';

  print(iso8601WithoutMicroseconds);

  final object = {
    "domain": domain,
    "address": address,
    "statement": statement,
    "uri": uri,
    "version": version,
    "chainId": chainId,
    "nonce": nonce,
    "issuedAt": iso8601WithoutMicroseconds
  };
  final message =
      "$domain wants you to sign in with your Ethereum account:\n$address\n\n$statement\n\nURI: $uri\nVersion: $version\nChain ID: $chainId\nNonce: $nonce\nIssued At: $iso8601WithoutMicroseconds";
  final signature =
      await provider.personalSign(message: message, address: address);
}
