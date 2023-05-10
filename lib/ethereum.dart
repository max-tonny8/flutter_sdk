import 'dart:convert';
import 'secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:siwe_flutter/library.dart';
import 'authentication_wrapper.dart';
import 'constants.dart';

Future<void> signWithEthereum(BuildContext context) async {
  await initializeProvider(
      context,
      'https://bridge.walletconnect.org',
      'MoonGate',
      'MoonGate Authentication Service',
      'https://moongate.one/',
      'https://www.joinef.com/wp-content/uploads/2023/03/MoonGate-5-Praneet-Sinha-700x700.png');
  await getNonce("$ipAddress/getnonce");
  await signInWithEthereum(
      'localhost:3000',
      'Sign in with MoonGate to prove ownership over this account',
      'localhost:3000',
      "1",
      "1");
  final data = await verifyMessage("$ipAddress/verify");

  // save the token to secure storage
  final secureStorage = SecureStorageUtil();
  await secureStorage.setAccessToken(jsonDecode(data)['token']);
  await authenticationHandler();
}
