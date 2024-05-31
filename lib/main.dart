import 'package:flutter/material.dart';
import 'package:qrbased_frontend/home.dart';
import 'welcome.dart';
import 'home.dart';
import 'balance_screen.dart';
import 'qrScannerpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child:
          //HomePage()
           //QRScannerPage(),  //BalanceScreen(),,
           WelcomeScreen(),
        ),
      ),
    );
  }
}

