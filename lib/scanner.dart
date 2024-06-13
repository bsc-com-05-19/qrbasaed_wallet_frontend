import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:qrbased_frontend/profile_page.dart';
import 'package:qrbased_frontend/qr_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeScannerPage extends StatefulWidget {
  final bool enableScanning; // Parameter to enable/disable scanning
  const QRCodeScannerPage({Key? key, this.enableScanning = true}) : super(key: key);

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  MobileScannerController? scannerController;
  TextEditingController currencyController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String scannedData = '';

  @override
  void initState() {
    super.initState();
    scannerController = MobileScannerController();
  }

  @override
  void dispose() {
    // Dispose of the scanner controller
    scannerController?.dispose();
    currencyController.dispose(); // Dispose of controllers
    amountController.dispose();
    super.dispose();
  }

  void _showDialog(String scannedData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF564FA1),
          title: Text(
            'Scanned QR Code',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.all(4),
                child: Text(
                  'Payee: $scannedData',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: currencyController,
                decoration: InputDecoration(
                  labelText: 'Currency',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Set border color to white
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Set border color to white
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF564FA1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showTransactionDetailsDialog(scannedData);
                    },
                    child: const Text('Proceed'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF564FA1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showTransactionDetailsDialog(String scannedData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF564FA1),
          title: Text(
            'Transaction Details',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payee: $scannedData',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Currency: ${currencyController.text}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Convenience Fee: USD 2',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Amount: ${amountController.text}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF564FA1),
                    ),
                    onPressed: () {
                      _createOrder(scannedData);
                    },
                    child: const Text('Pay'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF564FA1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _createOrder(String scannedData) async {
    try {
      // Retrieve stored session data including card details
      final prefs = await SharedPreferences.getInstance();
      final clientId = prefs.getString('client_id');
      final secretKey = prefs.getString('secret_key');
      final cardName = prefs.getString('card_name');
      final cardNumber = prefs.getString('card_number');
      final cardSecurityCode = prefs.getString('card_security_code');
      final cardExpiry = prefs.getString('card_expiry');

      // Check if clientId, secretKey, card details are available
      if (clientId == null ||
          secretKey == null ||
          cardName == null ||
          cardNumber == null ||
          cardSecurityCode == null ||
          cardExpiry == null) {
        throw Exception('Required data not found in session');
      }

      // Prepare card details
      final Map<String, dynamic> card = {
        'name': cardName,
        'number': cardNumber,
        'security_code': cardSecurityCode,
        'expiry': cardExpiry,
      };

      // Prepare data for the request
      final Map<String, dynamic> requestData = {
        'purchase_units': [
          {
            'amount': {
              'currency_code': currencyController.text, // Get currency from text field
              'value': amountController.text, // Get amount from text field
            },
            'payee': {
              'email_address': scannedData, // Use scanned data as payee email address
            }
          }
        ],
        'card': card, // Include card details in the request
        'clientId': clientId,
        'secretKey': secretKey,
      };

      final response = await http.post(
        Uri.parse('https://5930-41-70-47-51.ngrok-free.app/create-order'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Order created successfully
        final responseData = jsonDecode(response.body);
        // Handle success response as needed
        print('Order created successfully: $responseData');
        // Show success message to the user
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Payment captured successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle other status codes (e.g., 401, 404, 500)
        throw Exception('Failed to create order: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors
      print('Error creating order: $error');
      // Show error message to the user
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to create order. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Scan QR Code",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF564FA1),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return QRImage();
                  },
                ),
              ).then((value) {
                scannerController = MobileScannerController();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfilePage();
                  },
                ),
              ).then((value) {
                scannerController = MobileScannerController();
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (widget.enableScanning)
            MobileScanner(
              controller: scannerController!,
              onDetect: (barcode, args) {
                final String? code = barcode.rawValue;
                if (code != null) {
                  print("Scanned QR code: $code");
                  _showDialog(code);
                }
              },
            ),
          QRScannerOverlay(
            overlayColor: Colors.black54,
            borderRadius: 16,
            borderColor: Color(0xFF564FA1),
          ),
        ],
      ),
    );
  }
}
