import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jc_recruit_app/pages/starting_page.dart';
import 'package:jc_recruit_app/providers/firebase_provider.dart';
import 'package:jc_recruit_app/router/router.dart';
import 'package:jc_recruit_app/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jc_recruit_app/widgets/overlay_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.remove();

  runApp(GlobalLoaderOverlay(
    overlayColor: const Color.fromARGB(128, 23, 23, 23),
    overlayWidgetBuilder: (_) => const OverlayWidget(),
    child: MaterialApp.router(
      themeMode: ThemeMode.dark,
      theme: getAppTheme(),
      routerConfig: myRouter,
    ),
  ));
}
