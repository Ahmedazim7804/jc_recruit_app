import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jc_recruit_app/ui/pages/starting_page.dart';
import 'package:jc_recruit_app/router/router.dart';
import 'package:jc_recruit_app/service/user_service.dart';
import 'package:jc_recruit_app/ui/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jc_recruit_app/ui/common_widgets/overlay_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<bool> setup() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  UserService userService = UserService();

  final getIt = GetIt.instance;
  getIt.registerSingleton(sharedPreferences);
  getIt.registerSingleton(userService);

  return await userService.checkIfLoggedIn();
}

void main() async {
  bool loggedIn = await setup();

  FlutterNativeSplash.remove();
  runApp(GlobalLoaderOverlay(
    overlayColor: const Color.fromARGB(128, 23, 23, 23),
    overlayWidgetBuilder: (_) => const OverlayWidget(),
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: getAppTheme(),
      routerConfig: getMyRouter(loggedIn),
    ),
  ));
}
