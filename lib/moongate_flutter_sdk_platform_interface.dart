import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'moongate_flutter_sdk_method_channel.dart';

abstract class MoongateFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a MoongateFlutterSdkPlatform.
  MoongateFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static MoongateFlutterSdkPlatform _instance = MethodChannelMoongateFlutterSdk();

  /// The default instance of [MoongateFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelMoongateFlutterSdk].
  static MoongateFlutterSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MoongateFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(MoongateFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
