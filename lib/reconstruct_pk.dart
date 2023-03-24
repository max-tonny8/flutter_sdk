import 'dart:js';

import 'secure_storage_util.dart';
import 'package:ntcdcrypto/ntcdcrypto.dart';

Future<void> reconstructPrivateKey(String token) async {
  SSS sss = SSS();
  final secureStorage = SecureStorageUtil();
  String? keyShare = await secureStorage.getKeyShare();
  if (keyShare != null) {
    print('key share is $keyShare');
  } else {
    print('key share not found');
  }
}
