import 'package:checkout/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function onTap;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Material(
        color: AppColors.neutral,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: AppColors.neutral, 
          onTap: () {
            onTap();
          },
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(10),
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