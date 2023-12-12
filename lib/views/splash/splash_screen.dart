import 'package:checkout/viewmodels/auth/auth_google.dart';
import 'package:checkout/viewmodels/auth/auth_phone.dart';
import 'package:checkout/views/auth/login_page.dart';
import 'package:checkout/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/functions/next_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final pAP = Provider.of<AuthPhoneProvider>(context, listen: false);
    final gAP = Provider.of<AuthGoogleProvider>(context, listen: false);
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        pAP.isSignedIn == true
            ? nextScreenReplace(context: context, page: const HomeScreen())
            : nextScreenReplace(context: context, page: const LoginScreen());
        gAP.isSignedIn == false
            ? nextScreenReplace(context: context, page: const LoginScreen())
            : nextScreenReplace(context: context, page: const HomeScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.secondary,
              AppColors.primary,
              AppColors.neutral,
            ],
            stops: [0, .89, .89],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.appLogo,
              height: 100,
            ),
            Image.asset(
              AppImages.appName,
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
