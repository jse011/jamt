import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/qr/bloc/qr_bloc.dart';
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

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    setState(() {
      qrViewInitialized = true;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanResult.isEmpty) {
        if (context.mounted){
          context.read<QrBloc>().add(CodeScanData(scanData.code??''));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrBloc, QrState>(
      listener: (context, state) {
        if(!state.startScan){
          controller?.pauseCamera();
        }
      },
      child: Scaffold(
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
                    onQRViewCreated: (controller) => _onQRViewCreated(controller, context),
                    overlay: QrScannerOverlayShape(
                      overlayColor: AppColor.colorPrimary.withOpacity(0.3),
                      borderColor: AppColor.yellow,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 250,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 1500),
                  child: qrViewInitialized
                      ? Container(
                    key: ValueKey('shown'),
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
                  )
                      : SizedBox.shrink(key: ValueKey('hidden')),
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
                          fontSize: 28,
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
                        top: 350,
                        left: 32,
                        right: 32
                    ),
                    child: const Text(
                      "Escanea el código QR al ingresar o salir de la semiplenaria para registrar tu asistencia.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}
