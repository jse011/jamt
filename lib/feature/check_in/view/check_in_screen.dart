import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';
import 'package:lottie/lottie.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(
            color: Colors.brown,
          )),
          Positioned.fill(child: Container(
            color: Colors.black.withOpacity(0.1),
          )),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: Lottie.asset(
                      AppLottie.checkInCheck2
                  ),
                ),
                const Text(
                  "Registro exitoso",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Jose Francisco\nArias Orezano",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppFont.fontTwo
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "06 May 2025 a las 9:58 pm",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  "INGRESO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppFont.fontTwo
                  ),
                ),
                const Text(
                  "SEMIPLENARIA\nALVA Y ALVA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppFont.fontTwo
                  ),
                ),
                const Text(
                  "Sábado 8:40 HS",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Gracias por escanear\nTe registraste con éxito",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blue,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {},
                  child: const Text("Salir, si ya se registro mi asistencia", style: TextStyle(
                      color: Colors.white
                  ),),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "No cerrar hasta que se registre.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
