
import 'moongate_flutter_sdk_platform_interface.dart';

class MoongateFlutterSdk {
  Future<String?> getPlatformVersion() {
    return MoongateFlutterSdkPlatform.instance.getPlatformVersion();
  }
}
