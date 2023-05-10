import 'get_local_keyshare.dart';
import 'get_moongate_keyshare.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_util.dart';
import 'constants.dart';
import 'config.dart';

Future<void> secretReconstruction() async {
  String localKeyShare = await getLocalKeyShare();
  String moongateKeyShare = await getMoongateKeyShare();
  final secureStorage = SecureStorageUtil();
  /*  String? accessToken = await secureStorage.getAccessToken(); */
/*   if (accessToken != null) { */
  final response = await http.post(Uri.parse('$ipAddress/keyreconstruction'),
      headers: {
        'x-api-key': MoonGateConfig.apiKey,
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
    // encode the data
    var privateKey = jsonDecode(data)['privateKey'];
    var mnemonic = jsonDecode(data)['mnemonic'];
    // save the private key to secure storage
    await secureStorage.setPrivateKey(privateKey);
    // save the mnemonic to secure storage
    await secureStorage.setMnemonic(mnemonic);
  } else {
    // If the server returns an error response, throw an exception
    throw Exception('Failed to load data from backend');
  }
  /*  } */
}
