import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/base_viewmodel.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.showSuffixIcon = false,
  });

  final bool? obscureText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? showSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return Consumer<Obscure>(
      builder: (context, obscure, _) {
        return TextFormField(
          controller: controller,
          obscureText: obscureText! && !obscure.passwordVisible,
          keyboardType: keyboardType,
          onChanged: (value) => obscure.toggleTyped(value),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black26,
              fontSize: 16,
            ),
            suffixIcon: obscureText! && showSuffixIcon! && obscure.isTyped
                ? IconButton(
                    icon: Icon(
                      obscure.passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      obscure.togglePasswordVisibility();
                      Future.delayed(const Duration(seconds: 2), () {
                        obscure.togglePasswordVisibility();
                      });
                    },
                  )
                : null,
            contentPadding:
                const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        );
      },
    );
  }
}
