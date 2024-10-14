/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.iconData,
    this.labelText,
    this.obscureText,
    this.suffixIcon,
    this.isFirst,
    this.isLast,
    this.style,
    this.textAlign,
    this.suffix,
    this.isNext,
    this.enabled = true,
    this.controller,
  }) : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final IconData? iconData;
  final bool? obscureText;
  final bool? isFirst;
  final bool? isLast;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool? isNext;
  final bool? enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: lightGrayColor),
      child: TextFormField(
        // textInputAction: isNext ? TextInputAction.next : null,
        maxLines: keyboardType == TextInputType.multiline ? null : 1,
        key: key,
        keyboardType: keyboardType ?? TextInputType.text,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        style: style ?? Get.textTheme.bodyMedium,
        obscureText: obscureText ?? false,
        enabled: enabled,
        textAlign: textAlign ?? TextAlign.start,
        decoration: Ui.getInputDecoration(
          label: labelText ?? '',
          hintText: hintText ?? '',
          iconData: iconData,
          suffixIcon: suffixIcon,
          suffix: suffix,
          errorText: errorText,
        ),
        controller: controller,
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst!) {
      return BorderRadius.vertical(top: Radius.circular(12));
    }
    if (isLast!) {
      return BorderRadius.vertical(bottom: Radius.circular(12));
    }
    if (!isFirst! && !isLast!) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(12));
  }

  double get topMargin {
    if ((isFirst!)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast!)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
