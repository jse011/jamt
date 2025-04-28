import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:jamt/constants/constants.dart';
class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String scanResult = '';

  @override
  void reassemble() {
    super.reassemble();
    controller?.pauseCamera();
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanResult.isEmpty) {
        setState(() {
          scanResult = scanData.code ?? '';
        });
        controller.pauseCamera();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - 280;// 🔥 Aquí capturamos la altura de la pantalla

    return  Container(
      height: screenHeight,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Stack(
        children: [
         Positioned.fill(
             child:  Column(
               children: [
                 const SizedBox(height: 24),
                 const Text(
                   "Scan QR Code",
                   style: TextStyle(
                       fontSize: 24,
                       fontFamily: AppFont.fontTwo,
                       fontWeight: FontWeight.bold,
                       color: Colors.white
                   ),
                 ),
                 const SizedBox(height: 8),
                 const Text(
                   "Place QR inside the frame to scan",
                   style: TextStyle(color: Colors.grey),
                 ),
                 const SizedBox(height: 24),
               ],
             ),
         ),
          SizedBox(
            width: double.infinity,
            height: screenHeight,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: AppColor.blueLight,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}