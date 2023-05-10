import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_util.dart';
import 'constants.dart';
import 'config.dart';

Future checkForExistingKeys() async {
  final secureStorage = SecureStorageUtil();
  String? accessToken = await secureStorage.getAccessToken();
  if (accessToken != null) {
    final response = await http.post(Uri.parse('$ipAddress/checkforkeyshare'),
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
      data = data['shard'];
      if (data) {
        return true;
      } else {
        return false;
      }
    }
  } else {
    return false;
  }
}
