import 'package:flutter/material.dart';
import 'ScanQR.dart';
import 'loader.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMSME',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Loader(),
    );
  }
}
