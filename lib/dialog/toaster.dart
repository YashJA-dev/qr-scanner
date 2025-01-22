import 'package:flutter/material.dart';
import 'package:qrscanner/configs/app_colors.dart';
import 'package:toastification/toastification.dart';

class ToastMessage {
  static ToastificationItem show({
    required BuildContext context,
    required String title,
    required String description,
    required ToastificationType toastificationType,
    CloseButtonShowType? closeButtonShowType,
    ToastificationStyle? toastificationStyle,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    bool showProgressBar = true,
    bool dragToClose = true,
    Duration? autoCloseDuration,
    int seconds = 1,
  }) {
    return toastification.show(
      context: context,
      title: Text(
        title,
      ),
      description: Text(description),
      dragToClose: dragToClose,
      type: toastificationType,
      borderRadius: borderRadius,
      showProgressBar: false,
      closeButtonShowType: closeButtonShowType ?? CloseButtonShowType.always,
      padding: padding,
      autoCloseDuration: autoCloseDuration ??
          const Duration(
            seconds: 3,
          ),
      alignment: Alignment.topCenter,
      closeOnClick: true,
      primaryColor: AppColors.green,
      pauseOnHover: false,
      style: toastificationStyle ?? ToastificationStyle.flatColored,
    );
  }
}
