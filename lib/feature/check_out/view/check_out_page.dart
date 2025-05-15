import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/check_out/check_out.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});
  static const String routeName = '/checkOut';
  static Route<void> route() {
    return PageRouteBuilder<void>(
        opaque: false, // 👈 Esto es lo clave para permitir transparencia
        pageBuilder: (_, __, ___) => const CheckOutPage(),
        settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CheckOutBloc(
          getQrStateSemiPlenaryUseCase: GetQrStateSemiPlenaryUseCase(
              context.read<SemiPlenaryRepository>()
          )
        )
          ..add(CheckOutPageSubscriptionRequested()),
        child:  CheckOutScreen()
    );
  }
}