import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
        onLoadStop: (controller, url) async {
          if (url != null && url.toString().startsWith('moongate://')) {
            // Close the in-app browser
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
