import 'package:flutter/material.dart';
import 'package:qrbased_frontend/home.dart';
import 'package:qrbased_frontend/theme.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IZEpay',
      theme: AppTheme.lightTheme(context).copyWith(
        // Define the AlertDialogTheme with increased border radius
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Set the border radius here
          ),
        ),
      ),
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

