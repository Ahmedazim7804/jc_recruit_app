import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jc_recruit_app/router/router.dart';
import 'package:jc_recruit_app/ui/common_widgets/devcomm_logo.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                'assets/logo.svg',
                width: 48,
                height: 48,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Let's Get Started",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.75)),
              ),
              Text(
                "With AmulX, order food quickly in campus, tracking order and pay online",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14, color: Colors.white.withOpacity(0.75)),
              ),
              const SizedBox(
                height: 64,
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.SIGN_IN.value);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: const Color(0xff2846A8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white.withOpacity(0.75)),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.SIGN_UP.value);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xff2846A8)),
                        borderRadius: BorderRadius.circular(5))),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff2846A8)),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Privacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, color: Colors.white.withOpacity(0.6)),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "·",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, color: Colors.white.withOpacity(0.6)),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Terms of Services",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, color: Colors.white.withOpacity(0.6)),
                  ),
                ],
              ),
              const Spacer(),
              const DevcommLogo()
            ],
          )),
    );
  }
}
