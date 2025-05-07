import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jamt/feature/check_error/check_error.dart';

class CheckErrorDialog {
  static Future<void> show(BuildContext context) async {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Error',
      barrierColor: Colors.transparent, // importante para mostrar blur real
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Stack(
          children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // ✅ cerrar al tocar fuera
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black.withOpacity(0.3), // opcional: oscurecimiento ligero
            ),
          ),
        ),
            Center(
              child: Material(
                color: Colors.transparent,
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 400,
                    child:  CheckErrorScreen(),
                  ),
                ),
              )
            ),
          ],
        );
      },
    );
  }
}