import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'secure_storage_util.dart';

class AuthWebView extends StatefulWidget {
  final String url;
  final Function(String) onAuthenticated;

  AuthWebView({required this.url, required this.onAuthenticated});

  @override
  _AuthWebViewState createState() => _AuthWebViewState();
}

class _AuthWebViewState extends State<AuthWebView> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
          userAgent: "random",
        )),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) {
          print('onLoadStart: $url');
        },
        onLoadStop: (controller, url) {
          print('onLoadStop: $url');
          if (url.toString().startsWith('moongate://')) {
            String accessToken =
                Uri.parse(url.toString()).queryParameters['access_token']!;
            widget.onAuthenticated(accessToken);
            print('access token for moongate: $accessToken');
            _webViewController.clearCache();
            _webViewController.stopLoading();
          }
        },
        onLoadError: (controller, url, code, message) {
          print('onLoadError: $url, error code: $code, message: $message');
        },
      ),
    );
  }
}
