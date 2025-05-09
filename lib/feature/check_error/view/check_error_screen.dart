import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';
import 'package:lottie/lottie.dart';

class CheckErrorScreen extends StatelessWidget {
  const CheckErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.red.shade50,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 100),
              const Text(
                "Asistencia ya fue registrada",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "SEMIPLENARIA\nALVA Y ALVA",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: AppFont.fontTwo
                ),
              ),
              const Text(
                "Sábado 8:40 HS",
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              const SizedBox(height: 8),
              const Text(
                "Ya registraste tu asistencia.\nNo puedes volver a ingresar.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade800,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Salir", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Lottie.asset(AppLottie.checkErrorInfo,
              height: 120,
              width: 120,
              fit: BoxFit.contain,
            )),
      ],
    );
  }
}
