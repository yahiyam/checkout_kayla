import 'package:checkout/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 12),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        AppColors.primary,
      ),
    ),
  );
}
