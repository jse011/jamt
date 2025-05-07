import 'package:flutter/material.dart';
import 'package:jamt/feature/check_in/check_in.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CheckInPage());
  }

  @override
  Widget build(BuildContext context) {
    return CheckInScreen();
  }
}