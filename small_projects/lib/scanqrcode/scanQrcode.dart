import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  _ScanQRWidget createState() => _ScanQRWidget();
}

class _ScanQRWidget extends State<ScanQRCode> {
  String qrresult = "Scanned data will appear here";

  Future<void> scanQr() async {
    try {
      final qrcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR,
      );
      if (!mounted) return;
      setState(() {
        qrresult = qrcode.toString();
      });
    } on PlatformException {
      setState(() {
        qrresult = "Failed to read qr code";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Qr Code"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(qrresult, style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: scanQr, child: const Text("Scan Code")),
          ],
        ),
      ),
    );
  }
}
