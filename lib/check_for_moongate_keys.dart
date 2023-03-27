import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_util.dart';

Future checkForExistingKeys() async {
  final secureStorage = SecureStorageUtil();
  String? accessToken = await secureStorage.getAccessToken();
  if (accessToken != null) {
    final response =
        await http.post(Uri.parse('http://192.168.0.25:3005/checkforkeyshare'),
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
      data = data['shard'];
      if (data) {
        print('the shard exists');
        return true;
      } else {
        print('the shard does not exist');
        return false;
      }
    }
  } else {
    return false;
  }
}
