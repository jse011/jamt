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
  bool qrViewInitialized = false;

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
    setState(() {
      qrViewInitialized = true;
    });
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

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: SizedBox.expand(
                child: QRView(
                  key: qrKey,
                  overlayMargin: EdgeInsets.zero,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    overlayColor: AppColor.colorPrimary.withOpacity(0.3),
                    borderColor: AppColor.colorMenuPrimary,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 250,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: qrViewInitialized ? 1 : 0,
              duration: Duration(milliseconds: 2000),
              child: Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const [
                        Color.fromRGBO(224, 86, 31, 1), // 70%
                        Color.fromRGBO(0, 0, 0, 0.3), // 70%
                        Color.fromRGBO(0, 0, 0, 0), // 30%
                        Color.fromRGBO(0, 0, 0, 0.5), // 70%
                        Color.fromRGBO(224, 86, 31, 0.8), // 70%
                      ],
                      stops: const [0.0, 0.2, 0.3, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 48,
                  bottom: 20
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      "Escanea tu asistencia",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: AppFont.fontTwo,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 300,
                    left: 32,
                    right: 32
                  ),
                child: const Text(
                "Escanea el código QR al ingresar o salir de la semiplenaria para registrar tu asistencia.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              )
            )

          ],
        ),
      ),
    );

  }
}