import 'package:flutter/material.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/features/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/features/child/activities/activities.dart';
import 'package:voca_grow_app/features/parent/home/home.dart' as parenthome;
import 'package:voca_grow_app/features/splash/splash.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            lazy: false,
            create:
                (context) =>
                    AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
        ],
        child: const AppPage(),
      ),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Voca Grow App',
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              if (state.user.userType == UserType.parent) {
                _navigator.pushAndRemoveUntil<void>(
                  parenthome.HomePage.route(),
                  (route) => false,
                );
              } else {
                _navigator.pushAndRemoveUntil<void>(
                  ActivitiesPage.route(),
                  (route) => false,
                );
              }
            } else if (state is AuthUnauthenticated) {
              _navigator.pushAndRemoveUntil<void>(
                SelectLanguagePage.route(),
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
