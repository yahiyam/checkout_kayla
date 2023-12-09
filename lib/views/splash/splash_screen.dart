import 'package:checkout/viewmodels/auth_viewmodel.dart';
import 'package:checkout/views/auth/login_page.dart';
import 'package:checkout/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        ap.isSignedIn == true
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              )
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
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
