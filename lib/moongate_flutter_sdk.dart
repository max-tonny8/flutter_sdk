import 'moongate_flutter_sdk_platform_interface.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/* void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebView Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (_) => new WebviewScaffold(
              url: "https://www.google.com",
              appBar: new AppBar(
                title: new Text("Widget webview"),
              ),
            ),
      },
    );
  }
} */

class MoongateFlutterSdk {
  Future<String?> getPlatformVersion() async {
    /* const url =
        'http://13.40.184.28:3000/provider?provider=google&redirecturl=com.onemoongate.moongate_flutter_sdk_example';
    final uri = Uri.parse(url);

    // Launch the initial URL
    await launchUrl(uri);

    // Wait for the redirect and extract the access token
    final redirectUri = await uriLinkStream.firstWhere((Uri? uri) =>
        uri?.host == 'com.onemoongate.moongate_flutter_sdk_example');
    final accessToken = redirectUri?.queryParameters['access_token'];

    // Call the platform-specific method with the access token
    return accessToken; */
    return "test";
  }
}
