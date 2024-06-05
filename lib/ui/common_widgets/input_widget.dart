import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.hintText,
      required this.label,
      required this.icon,
      required this.keyboardType,
      required this.validator,
      required this.controller,
      this.obscureText = false});
  final String hintText;
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      child: TextFormField(
          style: TextStyle(color: Colors.white.withOpacity(0.75)),
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            fillColor: const Color(0xff2846A8),
            // filled: true,
            hintText: hintText,
            suffixIcon: Icon(icon, color: Colors.white.withOpacity(0.87)),
            label: Text(label,
                style: TextStyle(color: Colors.white.withOpacity(0.87))),
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.60)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.87))),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(color: Colors.redAccent.withOpacity(0.87))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.87))),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(color: Colors.redAccent.withOpacity(0.87))),
          )),
    );
  }
}
