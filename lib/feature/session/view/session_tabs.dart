import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/session/session.dart';

class SessionTabs extends StatelessWidget {
  const SessionTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SessionBloc(),
        child:  SessionScreen()
    );
  }


}