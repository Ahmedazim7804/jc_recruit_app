import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jc_recruit_app/pages/auth/signin_page.dart';
import 'package:jc_recruit_app/pages/auth/signup_page.dart';
import 'package:jc_recruit_app/pages/home_screen.dart';
import 'package:jc_recruit_app/pages/starting_page.dart';

enum AppRoutes {
  SIGN_UP('/auth/sign_up'),
  SIGN_IN('/auth/sign_in'),
  START_PAGE('/'),
  HOME_SCREEN('/home');

  final String value;
  const AppRoutes(this.value);
}

GoRouter getMyRouter(bool loggedIn) {
  String initialLocation =
      loggedIn ? AppRoutes.HOME_SCREEN.value : AppRoutes.START_PAGE.value;

  return GoRouter(initialLocation: initialLocation, routes: [
    GoRoute(
      name: AppRoutes.START_PAGE.name,
      path: AppRoutes.START_PAGE.value,
      pageBuilder: (context, state) {
        return const MaterialPage(child: StartPage());
      },
    ),
    GoRoute(
      name: AppRoutes.SIGN_UP.name,
      path: AppRoutes.SIGN_UP.value,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignUpPage());
      },
    ),
    GoRoute(
      name: AppRoutes.SIGN_IN.name,
      path: AppRoutes.SIGN_IN.value,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignInPage());
      },
    ),
    GoRoute(
      name: AppRoutes.HOME_SCREEN.name,
      path: AppRoutes.HOME_SCREEN.value,
      pageBuilder: (context, state) {
        return const MaterialPage(child: HomeScreen());
      },
    )
  ]);
}
