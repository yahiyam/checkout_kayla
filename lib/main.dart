import 'package:checkout/constants/app_colors.dart';
import 'package:checkout/constants/app_images.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnBoardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.appLogo,
              height: 100,
            ),
            Image.asset(
              Images.appName,
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
