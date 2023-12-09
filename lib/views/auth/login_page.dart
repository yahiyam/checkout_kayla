import 'package:checkout/utils/constants/app_colors.dart';
import 'package:checkout/utils/constants/app_images.dart';
import 'package:checkout/utils/constants/app_texts.dart';
import 'package:checkout/utils/widgets/button.dart';
import 'package:checkout/views/auth/widgets/textformfield_widget.dart';
import 'package:checkout/views/mobile/mobile_registration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 80),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTexts.appName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 120),
                CustomField(
                  hintText: 'Username',
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                  showSuffixIcon: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password ? ',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                const Text(
                  'Login With',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black26,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      splashColor: AppColors.splash,
                      splashFactory: InkRipple.splashFactory,
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset(
                          AppImages.google,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      splashColor: AppColors.splash,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MobileRegistration(),
                        ));
                      },
                      icon: const Icon(
                        Icons.dialpad,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                CustomButton(
                  text: 'Login',
                  onTap: () {},
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
