import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/const/app_color.dart';
import '../../core/const/app_dimens.dart';

class ErrorLoadingCameraWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorLoadingCameraWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'camera.error'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: AppDimens.medium),

          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainGreen,
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.large,
                vertical: AppDimens.medium,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.medium),
              ),
            ),
            child: Text(
              'button.retry'.tr(),
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
