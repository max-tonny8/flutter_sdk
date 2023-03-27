import 'secure_storage_util.dart';

Future checkForLocalKeys() async {
  final secureStorage = SecureStorageUtil();
  String? keyShare = await secureStorage.getKeyShare();
  if (keyShare != null) {
    return true;
  } else {
    return false;
  }
}
