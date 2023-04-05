import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_util.dart';

Future<void> createKeys() async {
  final secureStorage = SecureStorageUtil();
  String? accessToken = await secureStorage.getAccessToken();
  if (accessToken != null) {
    final response =
        await http.post(Uri.parse('http://192.168.0.18:3004/keygen'),
            headers: {
              'x-api-key': 'itu9sgo42ig0hhkp5xvfk',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "access_token": accessToken,
            }));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the data
      var data = response.body;
      // Do something with the data
      print('Data from backend: $data');
      await secureStorage.setKeyShare(data);
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data from backend');
    }
  } else {
    print('Access token not found');
  }
}
