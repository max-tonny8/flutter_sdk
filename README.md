# Flutter SDK: Ethereum Sign In

This guide will help you integrate the Ethereum sign in functionality into your Flutter app using the MoonGateConfig and MoonGateAuth from the Flutter SDK.

## Prerequisites

1. Make sure you have Flutter and Dart installed and set up.
2. Install the MoonGate Flutter SDK package in your project, you can do so by running
```dart 
flutter pub add moongate_flutter_sdk
```

## Getting Started

First, you need to set up the API key in your app. You can do this by calling the `MoonGateConfig.setApiKey` function with your API key as an argument.

```dart
import 'package:moongate_flutter_sdk/library.dart';

void main() {
  MoonGateConfig.setApiKey("YOUR API KEY HERE");
  runApp(MyApp());
}
```

Replace YOUR API KEY HERE with your actual API key.

## Implementing Ethereum Sign In
To implement Ethereum sign in, you can use the signWithEthereum and moonGateAuth functions provided by the MoonGate Flutter SDK.

Create a new function called connectWallet which will handle the sign in process:
    
```dart
import 'package:moongate_flutter_sdk/library.dart';

...

Future<void> connectWallet(BuildContext context) async {
  await signWithEthereum(context);
  String mnemonic = await moonGateAuth.getMnemonic();
  String privatekey = await moonGateAuth.getPrivateKey();
}
```

Make sure to pass the BuildContext context as an argument to the connectWallet function. This is required for the WalletConnect modal to show up.

Here's a simple example of how to use the connectWallet function in your app:

```dart
import 'package:moongate_flutter_sdk/library.dart';

void main() {
  MoonGateConfig.setApiKey("YOUR API KEY HERE");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Ethereum Sign In Example')),
        body: Center(child: SignInButton()),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await connectWallet(context);
      },
      child: Text('Connect Wallet'),
    );
  }
}

Future<void> connectWallet(BuildContext context) async {
  await signWithEthereum(context);
  String mnemonic = await moonGateAuth.getMnemonic();
  String privatekey = await moonGateAuth.getPrivateKey();
}
```
After the user has successfully signed in with their Ethereum wallet, the mnemonic and privatekey variables will contain the user's mnemonic phrase and private key, respectively. You can use these values to authenticate and perform various actions on behalf of the user within your app.

