import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/material.dart';
import 'auth_webview.dart';
import 'secure_storage_util.dart';

class MyAuthPlugin {
  static const MethodChannel _channel = const MethodChannel('my_auth_plugin');

  // Add any necessary variables here, such as API keys or URLs.
  final String _authBaseUrl = 'https://auth.moongate.one/provider';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> signInWithProvider(BuildContext context, String provider,
      String redirectUrl, String blockchain) async {
    // Implement the sign-in process using the in-app browser and your authentication URL
    // Redirect the user to the external OAuth provider for authentication
    // After successful authentication, obtain the JWT and store it securely
    String authUrl =
        'http://13.40.184.28:3000/provider?provider=$provider&redirecturl=$redirectUrl&blockchain=$blockchain';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthWebView(
          url: authUrl,
          onAuthenticated: (accessToken) async {
            // Store the access token securely
            final secureStorage = SecureStorageUtil();
            await secureStorage.setAccessToken(accessToken);
            // Perform any other necessary steps

            print('we have securedz ze access token $accessToken');
          },
        ),
      ),
    );
  }

  /* Future<String> getKeyShare() async {
    // Implement the API call to get the key share from your backend
    // Return the key share
  }

  Future<void> createKey() async {
    // Implement the API call to create a private key from the keygen endpoint
    // Store the private key securely in the application's local storage
  }

  Future<String> reconstructPrivateKey() async {
    // Retrieve the key share from your backend using getKeyShare()
    // Retrieve the local key share from secure storage
    // Reconstruct the private key using a reputable open-source Shamir Secret Sharing library
    // Return the reconstructed private key
  }

  Future<void> storePrivateKey(String privateKey) async {
    // Implement secure storage of the private key using FlutterSecureStorage
  }

  Future<void> signOut() async {
    // Clear the local storage and log the user out
  } */
}
