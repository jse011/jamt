import 'package:flutter/material.dart';

class WorkshopSelectCard extends StatelessWidget {
  final String title;
  final String value;
  final bool register;
  final VoidCallback onClosePressed;

  const WorkshopSelectCard({super.key, required this.title, required this.value, required this.register, required this.onClosePressed});

  @override
  Widget build(BuildContext context) {
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
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(value),
            ],
          )),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(register)
              const Icon(Icons.check_circle, color: Colors.grey, size: 32,), // Asistencia tomada
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
