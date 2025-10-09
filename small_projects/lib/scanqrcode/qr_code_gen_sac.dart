import 'package:flutter/material.dart';
import 'package:small_projects/scanqrcode/generate_Qr_code.dart';
import 'package:small_projects/scanqrcode/scanQrcode.dart';

class QrCodeGenSac extends StatefulWidget {
  const QrCodeGenSac({super.key});

  @override
  _Qrcode createState() => _Qrcode();
}

class _Qrcode extends State<QrCodeGenSac> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Generator"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanQRCode()),
                );
              },
              child: const Text("Scan Qr Code"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerateQrCode()),
                  );
                });
              },
              child: const Text("Generate Qr code"),
            ),
          ],
        ),
      ),
    );
  }
}
