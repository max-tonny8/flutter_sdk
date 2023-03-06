import 'package:flutter_test/flutter_test.dart';
import 'package:moongate_flutter_sdk/moongate_flutter_sdk.dart';
import 'package:moongate_flutter_sdk/moongate_flutter_sdk_platform_interface.dart';
import 'package:moongate_flutter_sdk/moongate_flutter_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMoongateFlutterSdkPlatform
    with MockPlatformInterfaceMixin
    implements MoongateFlutterSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MoongateFlutterSdkPlatform initialPlatform = MoongateFlutterSdkPlatform.instance;

  test('$MethodChannelMoongateFlutterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMoongateFlutterSdk>());
  });

  test('getPlatformVersion', () async {
    MoongateFlutterSdk moongateFlutterSdkPlugin = MoongateFlutterSdk();
    MockMoongateFlutterSdkPlatform fakePlatform = MockMoongateFlutterSdkPlatform();
    MoongateFlutterSdkPlatform.instance = fakePlatform;

    expect(await moongateFlutterSdkPlugin.getPlatformVersion(), '42');
  });
}
