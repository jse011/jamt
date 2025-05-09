import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/qr/bloc/qr_bloc.dart';
import 'package:jamt/feature/qr/qr.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const QRPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => QrBloc()
          ..add(QRPageSubscriptionRequested()),
        child:  ScanQrScreen()
    );
  }
}