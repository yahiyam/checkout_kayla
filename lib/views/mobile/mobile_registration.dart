import 'package:checkout/utils/constants/app_texts.dart';
import 'package:checkout/utils/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';

class MobileRegistration extends StatelessWidget {
  const MobileRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Add your phone number, We'll send you a verification code.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: phoneProvider.controller,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(13),
                    child: InkWell(
                      onTap: () {},
                      child: const Text(
                        " ${AppTexts.indianFlag}  +91",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  suffixIcon: phoneProvider.isMaxLengthReached
                      ? const Icon(Icons.check, color: Colors.green, size: 24)
                      : null,
                  counterText: "",
                ),
              ),
              const SizedBox(height: 120),
              phoneProvider.isMaxLengthReached
                  ? CustomButton(text: 'login', onTap: () {})
                  : const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
