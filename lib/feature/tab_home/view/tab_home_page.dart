import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/navigation/navigation.dart';

class TabHomePage extends StatelessWidget {
  const TabHomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const TabHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TabHomeBloc(),
        child:  TabHomeScreen()
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Logout'),
      onPressed: () {
        context.read<NavigationBloc>().add(AuthenticationLogoutPressed());
      },
    );
  }
}

class _UserId extends StatelessWidget {
  const _UserId();

  @override
  Widget build(BuildContext context) {
    final userId = context.select(
          (NavigationBloc bloc) => bloc.state.user.id,
    );

    return Text('UserID: $userId');
  }
}