import 'secure_storage_util.dart';

Future getLocalKeyShare() async {
  final secureStorage = SecureStorageUtil();
  String? keyShare = await secureStorage.getKeyShare();
  if (keyShare != null) {
    return keyShare;
  } else {
    return false;
  }
}
