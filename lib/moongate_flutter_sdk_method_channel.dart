import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'moongate_flutter_sdk_platform_interface.dart';

/// An implementation of [MoongateFlutterSdkPlatform] that uses method channels.
class MethodChannelMoongateFlutterSdk extends MoongateFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('moongate_flutter_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    var version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return "version test: $version";
  }
}
