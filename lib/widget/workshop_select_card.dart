import 'package:flutter/material.dart';
import 'package:jamt/constants/app_lottie.dart';
import 'package:jamt/widget/lottie_pause.dart';
import 'package:lottie/lottie.dart';

class WorkshopSelectCard extends StatelessWidget {
  final String title;
  final String value;
  final bool register;
  final bool disabled;
  final VoidCallback onClosePressed;


   const WorkshopSelectCard({super.key, required this.title, required this.value, required this.register, required this.disabled ,required this.onClosePressed});

  @override
  Widget build(BuildContext context) {

   var lottie = !disabled ?Lottie.asset(
      AppLottie.checkInCheck3,
      width: 48): LottiePause(lottiePath: AppLottie.checkInCheck3, progress: 0.8, width: 48,);

    return  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.mic, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(value),
                ],
              )
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(register)
                lottie,
              if(!register)
              const SizedBox(width: 8),
              if(!register)
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.red),
                onPressed: () {
                  onClosePressed.call();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
