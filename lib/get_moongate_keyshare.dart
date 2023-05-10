import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_util.dart';
import 'constants.dart';
import 'config.dart';

Future getMoongateKeyShare() async {
  final secureStorage = SecureStorageUtil();
  String? accessToken = await secureStorage.getAccessToken();
  if (accessToken != null) {
    final response = await http.post(Uri.parse('$ipAddress/getshard'),
        headers: {
          'x-api-key': MoonGateConfig.apiKey,
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
      return jsonEncode(moongateKey);
    } else {
      // If the server returns an error response, throw an exception
      /* throw Exception('Failed to load data from backend'); */
      return null;
    }
  } else {
    return null;
  }
}
