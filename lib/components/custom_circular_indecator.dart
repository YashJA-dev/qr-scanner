import 'package:flutter/material.dart';
import 'package:qrscanner/configs/app_colors.dart';

class CustomCircularIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
