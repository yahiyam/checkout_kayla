import 'package:checkout/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function onTap;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: AppColors.neutral,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          splashColor: AppColors.primary, 
          onTap: () {
            onTap();
          },
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(25),
            ),
            height: 40,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.neutral,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}