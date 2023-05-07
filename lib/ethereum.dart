import 'package:flutter/material.dart';
import 'package:siwe_flutter/library.dart';

Future<void> ethereumProvider(BuildContext context) async {
  await initializeProvider(
      context,
      'https://bridge.walletconnect.org',
      'MoonGate',
      'MoonGate Authentication Service',
      'https://moongate.one/',
      'https://www.joinef.com/wp-content/uploads/2023/03/MoonGate-5-Praneet-Sinha-700x700.png');
  await getNonce("http://192.168.1.222:3001/api/nonce");
  await signInWithEthereum(
      'localhost:3000',
      'Sign in with MoonGate to prove ownership over this account',
      'localhost:3000',
      "1",
      "1");
  await verifyMessage("http://192.168.1.222:3001/verify");
}
