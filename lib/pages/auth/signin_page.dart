import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jc_recruit_app/router/router.dart';
import 'package:jc_recruit_app/widgets/auth/error_dialog.dart';
import 'package:jc_recruit_app/widgets/devcomm_logo.dart';
import 'package:jc_recruit_app/widgets/input_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9_.+-]+@(?:(?:[a-zA-Z0-9-]+.)?[a-zA-Z]+.)?(nsut).ac.in$");

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailIsValid(String? input) {
    if (input == null || input.isEmpty) {
      return "Email is required";
    }

    if (emailRegex.hasMatch(input)) {
      return null;
    }

    return "Invalid email";
  }

  String? passwordIsValid(String? input) {
    if (input == null || input.isEmpty) {
      return "Password is required";
    }

    if (input.length < 8) {
      return "Password must be at least 8 characters";
    }

    return null;
  }

  bool get inputsAreValid {
    if (_formKey.currentState!.validate()) {
      return true;
    }

    return false;
  }

  Future<bool> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Unknown error occurred. Please try again later.";

      if (e.code == "invalid-credential") {
        errorMessage = "Invalid credentials. Please try again.";
      }

      AuthErrorDialog.show(context, errorMessage);
    }

    return false;
  }

  void submitForm() {
    if (inputsAreValid) {
      context.loaderOverlay.show();
      signInWithEmailAndPassword().then((value) {
        context.loaderOverlay.hide();
        if (value) {
          context.go(AppRoutes.HOME_SCREEN.value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              SvgPicture.asset(
                'assets/shape.svg',
                color: const Color(0xff2846A8),
              ),
              Positioned(
                  top: 128,
                  left: 8,
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    width: 48,
                    height: 48,
                    color: Colors.white.withOpacity(0.75),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).padding.top),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ))),
            ]),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white.withOpacity(0.75)),
                      ),
                      const SizedBox(height: 16),
                      InputWidget(
                          icon: Icons.email_outlined,
                          hintText: "Enter your email",
                          label: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: emailIsValid,
                          controller: emailController),
                      InputWidget(
                        icon: Icons.lock_outlined,
                        hintText: "Enter your password",
                        label: "Password",
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: passwordIsValid,
                        controller: passwordController,
                      ),
                      ElevatedButton(
                          onPressed: submitForm,
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: const Color(0xff2846A8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Text("Submit",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.75)))),
                    ],
                  ),
                )),
            const DevcommLogo()
          ],
        ),
      ),
    );
  }
}
