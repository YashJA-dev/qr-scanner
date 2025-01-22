import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrscanner/configs/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? initialValue;
  final EdgeInsets? padding;
  final int maxLines;
  final bool obscureText;
  final AutovalidateMode autovalidateMode;
  final String? Function(String? value)? validator;
  final void Function(String value) onChanged;
  final void Function(String value)? onFieldSubmitted;
  final void Function()? onTap;
  final bool? readOnly;
  final TextInputType? textInputType;
  final bool isDateField;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? hintText;
  final int? maxLength;
  final InputDecoration? decorator;
  final String? errorText;
  final bool autoFocus;
  final BorderRadius borderRadius;
  final TextAlign textAlign;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.padding,
    this.hintText,
    this.maxLines = 1,
    this.obscureText = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.onFieldSubmitted,
    required this.onChanged,
    this.onTap,
    this.prefix,
    this.readOnly,
    this.textInputType,
    this.isDateField = false,
    this.focusNode,
    this.onEditingComplete,
    this.enabled = true,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.decorator,
    this.errorText,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.58)),
  });

  CustomTextFormField copyWith(
      {Key? key,
      String? label,
      TextEditingController? controller,
      String? initialValue,
      EdgeInsets? padding,
      int? maxLines,
      bool? obscureText,
      AutovalidateMode? autovalidateMode,
      String? Function(String? value)? validator,
      void Function(String value)? onChanged,
      void Function(String value)? onFieldSubmitted,
      void Function()? onTap,
      bool? readOnly,
      TextInputType? textInputType,
      bool isDateField = false,
      FocusNode? focusNode,
      Function()? onEditingComplete,
      InputDecoration? decorator,
      String? errorText}) {
    return CustomTextFormField(
      label: label ?? this.label,
      controller: controller ?? this.controller,
      initialValue: initialValue,
      padding: padding ?? this.padding,
      maxLines: maxLines ?? this.maxLines,
      obscureText: obscureText ?? this.obscureText,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      validator: validator ?? this.validator,
      onChanged: onChanged ?? this.onChanged,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      onTap: onTap ?? this.onTap,
      readOnly: readOnly ?? this.readOnly,
      textInputType: textInputType ?? this.textInputType,
      isDateField: isDateField,
      focusNode: focusNode ?? this.focusNode,
      decorator: decorator ?? this.decorator,
      errorText: errorText ?? this.errorText,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      initialValue: initialValue,
      enabled: enabled,
      autofocus: autoFocus,
      decoration: isDateField
          ? inputDecoration(label, padding).copyWith(
              suffixIcon: const Icon(
                Icons.calendar_month_outlined,
              ),
              hintText: hintText,
              suffixIconColor: AppColors.primary,
              errorText: errorText,
            )
          : decorator ??
              inputDecoration(label, padding)
                  .copyWith(
                    prefix: prefix,
                    errorText: errorText,
                    hintText: hintText,
                  )
                  .copyWith(
                    prefix: prefix,
                    errorText: errorText,
                    hintText: hintText,
                  ),
      // style: AppColors.labelRegular,
      cursorColor: AppColors.primary,
      obscureText: obscureText,
      maxLines: maxLines,
      autovalidateMode: autovalidateMode,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap ?? () {},
      readOnly: readOnly ?? false,
      keyboardType: textInputType,
      onEditingComplete: onEditingComplete,
      maxLength: maxLength,
      textAlign: textAlign,
    );
  }

  InputDecoration inputDecoration(String label, [EdgeInsets? contentPadding]) {
    return InputDecoration(
      label: Text(
        label,
      ),
      hintStyle: TextStyle(
        color: AppColors.darkGray,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      labelStyle: TextStyle(
        color: AppColors.darkGray,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      contentPadding:
          contentPadding ?? const EdgeInsets.fromLTRB(12, 12, 12, 16),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.58),
        borderSide: BorderSide(
          color: AppColors.lightPrimary,
          width: 1.25,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.58),
        borderSide: BorderSide(
          color: AppColors.lightPrimary,
          width: 1.25,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.58),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      errorBorder: enabled
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.58),
              borderSide: BorderSide(
                color: AppColors.red,
                width: 0.8,
              ),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.58),
              borderSide: BorderSide(
                color: AppColors.lightPrimary,
                width: 1.25,
              ),
            ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.58),
        borderSide: BorderSide(
          color: AppColors.red,
          width: 0.8,
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    String value = newValue.text;

    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    } else if (value.contains(".")) {
      String tempValue = value.substring(value.indexOf(".") + 1);
      if (tempValue.contains(".")) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      }
      if (value.indexOf(".") == 0) {
        truncated = "0" + truncated;
        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }
    }
    if (value.contains(" ") || value.contains("-")) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class LeadingSpaceRemoverAndCapitalizerFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove leading spaces
    String trimmedValue = newValue.text.trimLeft();

    // Capitalize the first character
    String formattedValue = trimmedValue.isNotEmpty
        ? trimmedValue[0].toUpperCase() + trimmedValue.substring(1)
        : trimmedValue;

    // Calculate the new cursor position
    int cursorOffset = newValue.selection.baseOffset -
        (newValue.text.length - formattedValue.length);

    // Ensure cursorOffset is within the bounds of the formatted text
    cursorOffset = cursorOffset.clamp(0, formattedValue.length);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: cursorOffset),
      ),
      composing: TextRange.empty,
    );
  }
}
