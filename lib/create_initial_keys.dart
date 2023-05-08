import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_util.dart';
import 'constants.dart';
import 'config.dart';

Future<void> createKeys() async {
  final secureStorage = SecureStorageUtil();
  String? accessToken = await secureStorage.getAccessToken();
  if (accessToken != null) {
    final response = await http.post(Uri.parse('$ipAddress:3004/keygen'),
        headers: {
          'x-api-key': MoonGateConfig.apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "access_token": accessToken,
        }));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the data
      var data = response.body;
      // Do something with the data
      await secureStorage.setKeyShare(data);
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data from backend');
    }
  } else {
    print('Access token not found');
  }
}
