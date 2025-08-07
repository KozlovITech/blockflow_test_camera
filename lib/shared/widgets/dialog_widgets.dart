import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/const/app_color.dart';
import '../../core/const/app_dimens.dart';
import 'buttons_widget.dart';

class PermissionDeniedDialog {
  final BuildContext context;
  final String title;
  final String subtitle;
  final VoidCallback confirmAction;

  const PermissionDeniedDialog({
    required this.context,
    required this.confirmAction,
    required this.title,
    required this.subtitle,
  });

  void show() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return PopScope(
          canPop: false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.large),
            ),
            backgroundColor: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.big),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: AppDimens.small),

                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: AppDimens.big),

                  Column(
                    spacing: AppDimens.tiny,
                    children: [
                      CustomOutlineButton(
                        label: 'button.open_settings'.tr(),
                        borderColor: AppColors.mainGreen,
                        onPressed: confirmAction,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
