import 'secure_storage_util.dart';
import 'create_initial_keys.dart';
import 'reconstruct_pk.dart';
import 'check_local_keys.dart';
import 'check_for_moongate_keys.dart';
import 'local_key_recovery.dart';

Future<void> authenticationHandler() async {
  final secureStorage = SecureStorageUtil();
  // Retrieve the access token from secure storage.
  String? accessToken = await secureStorage.getAccessToken();
  if (accessToken != null) {
    bool? hasKeys = await checkForExistingKeys();
    print('hasKeys: $hasKeys');
    bool? hasLocalKeys = await checkForLocalKeys();
    print('hasLocalKeys: $hasLocalKeys');
    // If the user has a keyshare with MoonGate
    if (hasKeys == true) {
      // If the user has a local keyshare
      if (hasLocalKeys == true) {
        reconstructPrivateKey();
      } else {
        // If the user doesn't have a local keyshare, initiate the key recovery process and store the device key share.
        await localKeyRecovery();
        // Then reconstruct the PK.
        await reconstructPrivateKey();
      }
    } else {
      // If the user doesn't have a keyshare, initiate the keygen process and store the device key share.
      await createKeys();
      // Then reconstruct the PK.
      await reconstructPrivateKey();
    }
  }
}
