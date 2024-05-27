import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? result;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          // Back Button
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF564FA1)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // "My QR" Button
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35, // Set width here
            height: 60, // Set height here
            child: Padding(
              padding: const EdgeInsets.only(top: 22.0), // Add some space at the top
              child: ElevatedButton.icon(
                onPressed: () {
                  // Action for the button
                },
                label: const Text('My QR'),
                icon: const Icon(Icons.qr_code_scanner),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF564FA1),
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // QR Scanner
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: const Color(0xFF564FA1),
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          const Spacer(),
          // Text and Camera Button
          Column(
            children: [
              Text(
                'Hold steady and capture',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),
              Center(
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, size: 40, color: Color(0xFF564FA1)),
                  onPressed: () {
                    controller?.resumeCamera();
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
