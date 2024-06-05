import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jc_recruit_app/router/router.dart';
import 'package:jc_recruit_app/ui/pages/auth/widgets/error_dialog.dart';
import 'package:jc_recruit_app/ui/common_widgets/devcomm_logo.dart';
import 'package:jc_recruit_app/ui/common_widgets/input_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9_.+-]+@(?:(?:[a-zA-Z0-9-]+.)?[a-zA-Z]+.)?(nsut).ac.in$");
  final nameRegex = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
  final studentIdRegex = RegExp(r"^\d{4}[a-zA-Z]{3}\d{4}$");

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();

  String? emailIsValid(String? input) {
    if (input == null || input.isEmpty) {
      return "Email is required";
    }

    if (emailRegex.hasMatch(input)) {
      return null;
    }

    return "Invalid email";
  }

  String? nameIsValid(String? input) {
    if (input == null || input.isEmpty) {
      return "Name is required";
    }

    if (nameRegex.hasMatch(input)) {
      return null;
    }

    return "Invalid name";
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

  String? studentIdIsValid(String? input) {
    if (input == null || input.isEmpty) {
      return "Student ID is required";
    }

    if (studentIdRegex.hasMatch(input)) {
      return null;
    }

    return "Invalid student id";
  }

  bool get inputsAreValid {
    if (_formKey.currentState!.validate()) {
      return true;
    }

    return false;
  }

  Future<bool> signUpWithEmailAndPassword() async {
    late final UserCredential userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      final uid = userCredential.user!.uid;

      final db = FirebaseFirestore.instance;

      await db.collection('users').doc(uid).set({
        'name': nameController.text,
        'email': emailController.text,
        'studentId': studentIdController.text,
      });

      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Unknown error occurred. Please try again later.";

      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }

      AuthErrorDialog.show(context, errorMessage);
    } catch (e) {
      return false;
    }

    return false;
  }

  void submitForm() async {
    if (inputsAreValid) {
      context.loaderOverlay.show();
      if (await signUpWithEmailAndPassword()) {
        context.go(AppRoutes.HOME_SCREEN.value);
      }
      context.loaderOverlay.hide();
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    studentIdController.dispose();
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
                        "Create your Account",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white.withOpacity(0.75)),
                      ),
                      const SizedBox(height: 16),
                      InputWidget(
                        icon: Icons.person_outlined,
                        hintText: "Enter your name",
                        label: "Name",
                        keyboardType: TextInputType.name,
                        validator: nameIsValid,
                        controller: nameController,
                      ),
                      InputWidget(
                          icon: Icons.email_outlined,
                          hintText: "Enter your email",
                          label: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: emailIsValid,
                          controller: emailController),
                      InputWidget(
                        icon: Icons.school_outlined,
                        hintText: "Enter your student id",
                        label: "Student ID",
                        keyboardType: TextInputType.text,
                        validator: studentIdIsValid,
                        controller: studentIdController,
                      ),
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
