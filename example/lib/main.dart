import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:moongate_flutter_sdk/moongate_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:moongate_flutter_sdk/my_auth_plugin.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Auth Plugin Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Auth Plugin Example App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyAuthPlugin myAuthPlugin = MyAuthPlugin();
  void handleIncomingLinks() async {
    try {
      Uri? initialLink = await getInitialUri();
      print('Initial link: $initialLink');
      if (initialLink != null &&
          initialLink.toString().startsWith('moongate://')) {
        String accessToken = initialLink.queryParameters['access_token'] ?? '';
        // Perform any necessary actions with the access token
      }

      // Handle deep links while the app is running
      uriLinkStream.listen((Uri? incomingLink) {
        print('Incoming link: $incomingLink');
        if (incomingLink != null &&
            incomingLink.toString().startsWith('moongate://')) {
          String accessToken =
              incomingLink.queryParameters['access_token'] ?? '';
          // Perform any necessary actions with the access token
        }
      }, onError: (err) {
        // Handle any errors
      });
    } catch (e) {
      // Handle any errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                myAuthPlugin.signInWithProvider(
                    context, 'discord', 'moongate://', 'ethereum');
              },
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
