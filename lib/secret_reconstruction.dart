import 'get_local_keyshare.dart';
import 'get_moongate_keyshare.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_util.dart';

Future<void> secretReconstruction() async {
  String localKeyShare = await getLocalKeyShare();
  String moongateKeyShare = await getMoongateKeyShare();
  print(localKeyShare);
  final secureStorage = SecureStorageUtil();
  /*  String? accessToken = await secureStorage.getAccessToken(); */
/*   if (accessToken != null) { */
  final response =
      await http.post(Uri.parse('http://192.168.0.18:3007/keyReconstruction'),
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
    // encode the data
    // get the privatekey field from data object and print it
    var privateKey = jsonDecode(data)['privateKey'];
    var mnemonic = jsonDecode(data)['mnemonic'];
    print('Reconstructed Private Key: $privateKey');
    // save the private key to secure storage
    await secureStorage.setPrivateKey(privateKey);
    print('Reconstructed Mnemonic: $mnemonic');
    // save the mnemonic to secure storage
    await secureStorage.setMnemonic(mnemonic);
  } else {
    // If the server returns an error response, throw an exception
    throw Exception('Failed to load data from backend');
  }
  /*  } */
}
