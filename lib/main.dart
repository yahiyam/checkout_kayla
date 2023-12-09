import 'package:checkout/utils/constants/app_colors.dart';
import 'package:checkout/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/splash/splash_screen.dart';

void main(List<String> args) {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Obscure()),
    ChangeNotifierProvider(create: (context) => PhoneProvider()),
  ], child: const CheckoutApp()));
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
