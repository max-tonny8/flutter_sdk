import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_util.dart';
import 'reconstruct_pk.dart';

Future<void> getMoongateKeyShare() async {
  final secureStorage = SecureStorageUtil();
  String? accessToken = await secureStorage.getAccessToken();
  if (accessToken != null) {
    print("when sending the request, the access token is $accessToken");
    final response =
        await http.post(Uri.parse('http://192.168.0.25:3003/getshard'),
            headers: {
              'x-api-key': 'itu9sgo42ig0hhkp5xvfk',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "access_token": accessToken,
            }));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the data
      var data = jsonDecode(response.body);
      Map<String, dynamic> moongateKey = data[0]['share_data'];
      // Do something with the data
      print('MoonGate Key Share: $moongateKey');
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data from backend');
    }
  } else {
    print('Access token not found');
  }
}
