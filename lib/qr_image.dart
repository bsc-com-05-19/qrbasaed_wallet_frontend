import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class QRImage extends StatefulWidget {
  static String routeName = "/qrimage";
  const QRImage({Key? key}) : super(key: key);

  @override
  _QRImageState createState() => _QRImageState();
}

class _QRImageState extends State<QRImage> {
  String _qrData = 'https://example.com';
  String? _savedFilePath;
  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadQRData();
  }

  Future<void> _loadQRData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _qrData = prefs.getString('email') ?? 'https://example.com';
    });
  }

  Future<void> _saveQRImage() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        String? outputFile = await FilePicker.platform.saveFile(
          dialogTitle: 'Please select an output file:',
          fileName: 'qr_code.png',
        );

        if (outputFile != null) {
          final file = File(outputFile);
          await file.writeAsBytes(pngBytes);
          final fileSize = await file.length();
          print('File size: $fileSize bytes');
          if (fileSize > 0) {
            setState(() {
              _savedFilePath = outputFile;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('QR Code saved at $outputFile')),
            );
          } else {
            throw Exception('File writing failed, file size is zero');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File save operation cancelled.')),
          );
        }
      } else {
        throw Exception('Failed to convert image to byte data');
      }
    } catch (e) {
      print('Error saving QR code image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save QR Code: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My QRCode",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF564FA1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: QrImageView(
                data: _qrData,
                size: 280,
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(100, 100),
                ),
              ),
            ),
            if (_savedFilePath != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Saved file at: $_savedFilePath',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
