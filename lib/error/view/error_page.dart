import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/navigation/pages.dart';

import '../../core/const/app_color.dart';
import '../../core/const/app_dimens.dart';

class ErrorPage extends StatelessWidget {
  static const String id = 'error';

  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Text(
                'error.common_title'.tr(),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                child: Text('error.button'.tr()),
                onPressed: () => context.go(Routes.cameraRoute),
              ),
              const SizedBox(height: AppDimens.large),
            ],
          ),
        ),
      ),
    );
  }
}
