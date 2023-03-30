import 'get_local_keyshare.dart';
import 'get_moongate_keyshare.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_util.dart';

Future<void> reconstructPrivateKey() async {
  String localKeyShare = await getLocalKeyShare();
  String moongateKeyShare = await getMoongateKeyShare();
  print(localKeyShare);
  final secureStorage = SecureStorageUtil();
  /*  String? accessToken = await secureStorage.getAccessToken(); */
/*   if (accessToken != null) { */
  final response =
      await http.post(Uri.parse('http://192.168.0.25:3007/keyReconstruction'),
          headers: {
            'x-api-key': 'itu9sgo42ig0hhkp5xvfk',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            /*  "access_token": accessToken, */
            "shareA": localKeyShare,
            "shareB": moongateKeyShare,
          }));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the data
    var data = response.body;
    print('Reconstructed Private Key: $data');
  }
  /*  } */
}
