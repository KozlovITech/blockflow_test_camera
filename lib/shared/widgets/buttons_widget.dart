import 'package:flutter/material.dart';

import '../../core/const/app_color.dart';
import '../../core/const/app_dimens.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final Color borderColor;
  final VoidCallback onPressed;

  const CustomOutlineButton({
    super.key,
    required this.label,
    required this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.inputAndButtonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.borderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.large,
            vertical: AppDimens.medium,
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
