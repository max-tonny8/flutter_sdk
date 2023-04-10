import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'auth_webview.dart';
import 'secure_storage_util.dart';
import 'authentication_wrapper.dart';

class MoonGateAuth {
  static const MethodChannel _channel = const MethodChannel('moongate_auth');

  // Add any necessary variables here, such as API keys or URLs.
  final String _authBaseUrl = 'https://auth.moongate.one/provider';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> signInWithProvider(BuildContext context, String provider,
      String redirectUrl, String blockchain) async {
    // Implement the sign-in process using the in-app browser and your authentication URL
    // Redirect the user to the external OAuth provider for authentication
    // After successful authentication, obtain the JWT and store it securely
    String authUrl =
        'https://auth-bice-mu.vercel.app/provider?provider=$provider&redirecturl=$redirectUrl&blockchain=$blockchain';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthWebView(
          url: authUrl,
          onAuthenticated: (accessToken) async {
            // Store the access token securely
            final secureStorage = SecureStorageUtil();
            await secureStorage.setAccessToken(accessToken);
            await authenticationHandler();
          },
        ),
      ),
    );
  }

  // expose methods for getting private key and mnemonic
  Future<String?> getPrivateKey() async {
    final secureStorage = SecureStorageUtil();
    return await secureStorage.getPrivateKey();
  }

  Future<String?> getMnemonic() async {
    final secureStorage = SecureStorageUtil();
    return await secureStorage.getMnemonic();
  }
}
