import 'package:checkout/utils/constants/app_colors.dart';
import 'package:checkout/utils/constants/app_images.dart';
import 'package:checkout/utils/constants/app_texts.dart';
import 'package:checkout/utils/widgets/button.dart';
import 'package:checkout/viewmodels/auth/auth_google.dart';
import 'package:checkout/viewmodels/base_viewmodel.dart';
import 'package:checkout/views/auth/sign_up_page.dart';
import 'package:checkout/views/auth/widgets/textformfield_widget.dart';
import 'package:checkout/views/mobile/mobile_registration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/functions/next_screen.dart';
import '../../utils/functions/snackbar.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // handle after signin
    handleAfterSignIn() {
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        nextScreenReplace(context: context, page: const HomeScreen());
      });
    }

    Future handleGoogleSignIn() async {
      final sp = context.read<AuthGoogleProvider>();
      final ip = context.read<InternetProvider>();
      await ip.checkInternetConnection();

      if (ip.hasInternet == false) {
        if (context.mounted) {
          openSnackbar(context, "Check your Internet connection", Colors.red);
        }
      } else {
        await sp.signInWithGoogle().then((value) {
          if (sp.hasError == true) {
            openSnackbar(context, sp.errorCode.toString(), Colors.red);
          } else {
            // checking whether user exists or not
            sp.checkUserExists().then((value) async {
              if (value == true) {
                // user exists
                await sp.getUserDataFromFirestore(sp.uid).then((value) {
                  handleAfterSignIn();
                });
              } else {
                // user does not exist
                sp.saveDataToFirestore().then((value) {
                  handleAfterSignIn();
                });
              }
            });
          }
        });
      }
    }

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
                Form(
                  // key: loginProvider.loginFormKey,
                  child: Column(
                    children: [
                      const CustomField(
                        hintText: 'Username',
                        // controller: loginProvider.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      const CustomField(
                        hintText: 'Password',
                        obscureText: true,
                        // controller: loginProvider.passwordController,
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
                      CustomButton(
                        text: 'Login',
                        onTap: () {},
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
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
                      onTap: () => handleGoogleSignIn(),
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                      },
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
