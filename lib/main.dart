import 'package:checkout/utils/constants/app_colors.dart';
import 'package:checkout/viewmodels/auth/auth_google.dart';
import 'package:checkout/viewmodels/auth/auth_phone.dart';
import 'package:checkout/viewmodels/base_viewmodel.dart';
import 'package:checkout/viewmodels/student_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/auth/auth_email_log_in.dart';
import 'viewmodels/auth/auth_email_sign_up.dart';
import 'views/splash/splash_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => Obscure()),
      ChangeNotifierProvider(create: (context) => PhoneNumberProvider()),
      ChangeNotifierProvider(create: (context) => AuthPhoneProvider()),
      ChangeNotifierProvider(create: (context) => AuthGoogleProvider()),
      ChangeNotifierProvider(create: (context) => AuthEmailSignUpProvider()),
      ChangeNotifierProvider(create: (context) => AuthEmailLogInProvider()),
      ChangeNotifierProvider(create: (context) => InternetProvider()),
      ChangeNotifierProvider(create: (context) => ImagesProvider()),
      ChangeNotifierProvider(create: (context) => StudentViewModel()),
    ], child: const CheckoutApp()),
  );
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      title: "Checkout App",
    );
  }
}
