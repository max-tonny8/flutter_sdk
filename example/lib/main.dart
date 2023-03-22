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
                    context, 'google', 'moongate://', 'ethereum');
              },
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
