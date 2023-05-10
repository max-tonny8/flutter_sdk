import 'package:flutter/material.dart';
import 'package:moongate_flutter_sdk/library.dart';
import 'dart:async';

void main() {
  String userApiKey = 'your_api_key_here';
  MoonGateConfig.setApiKey(userApiKey);
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
      home: MyHomePage(title: 'MoonGate Auth Plugin Example'),
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
  // Get the mnemonic once the user has authenticated from moongateAuth.getMnemonic()
  MoonGateAuth moonGateAuth = MoonGateAuth();
  @override
  String? mnemonic = '';
  String? privatekey = '';
  Widget build(BuildContext context) {
    // Create a function that sign ins with provider and then get the mnemonic once the user has authenticated
    Future<void> signInWithProvider(
        String provider, String redirectUrl, String chain) async {
      await moonGateAuth.signInWithProvider(
          context, provider, redirectUrl, chain);
      mnemonic = await moonGateAuth.getMnemonic();
      privatekey = await moonGateAuth.getPrivateKey();
      print(mnemonic);
    }

    Future<void> connectWallet() async {
      print('connect wallet');
      await signWithEthereum(context);
      mnemonic = await moonGateAuth.getMnemonic();
      privatekey = await moonGateAuth.getPrivateKey();
      print(mnemonic);
    }

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
                  signInWithProvider('discord', 'moongate://', 'tezos');
                },
                child: Text('Log In with Provider')),
            SizedBox(height: 16), // Add some spacing between the buttons
            ElevatedButton(
              onPressed: () async {
                // add wallet code here
                connectWallet();
              },
              child: Text('Connect wallet'),
            ),
          ],
        ),
      ),
    );
  }
}
