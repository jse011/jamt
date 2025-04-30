import 'package:app_localization/app_localizations.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/qr/qr.dart';
import 'package:jamt/navigation/navigation.dart';
import 'package:user_repository/user_repository.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/feature/splash/splash.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/feature/login/login.dart';
import 'package:jamt/feature/user/user.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationRepository(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider(create: (_) => UserRepository()),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) => NavigationBloc(
          authenticationRepository: context.read<AuthenticationRepository>(),
          userRepository: context.read<UserRepository>(),
        )..add(AuthenticationSubscriptionRequested()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<NavigationBloc, NavigationState>(
          listener: (context, state) {
            var removeStack = !state.initial;
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                switch(state.destination){
                  case Destination.tabHome:
                    _navigator.pushAndRemoveUntil<void>(
                      TabHomePage.route(),
                          (route) => removeStack,
                    );
                    break;
                  case Destination.profile:
                    _navigator.pushAndRemoveUntil<void>(
                      UserPage.route(),
                          (route) => removeStack,
                    );
                    break;
                  case Destination.qr:
                    _navigator.pushAndRemoveUntil<void>(
                      QRPage.route(),
                          (route) => removeStack,
                    );
                    break;
                  case Destination.sessions:

                    break;
                  case Destination.guests:
                  // Acción o retorno para invitados
                    break;
                  case Destination.bulletins:
                  // Acción o retorno para boletines
                    break;
                  case Destination.trivia:
                  // Acción o retorno para trivia
                    break;
                  case Destination.map:
                  // Acción o retorno para mapa
                    break;
                  case Destination.menu:
                  // Acción para mostrar el drawer o modal
                    break;
                  case Destination.logout:
                  // Acción para mostrar el drawer o modal
                    break;
                }
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                      (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColor.colorPrimary,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColor.colorPrimary,
  cardTheme: const CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  ),
  fontFamily: AppFont.font,
);