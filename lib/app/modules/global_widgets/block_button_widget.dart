import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_time_customer/common/ui.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget({
    Key? key,
    this.color,
    this.textColor,
    this.shadow = true,
    this.disabled = false,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final Color? color;
  final Color? textColor;
  final String text;
  final bool disabled;
  final bool shadow;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: disabled || !shadow
            ? null
            : [
                BoxShadow(
                    color: (color ?? Get.theme.colorScheme.primary)
                        .withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 1)),
                BoxShadow(
                    color: (color ?? Get.theme.colorScheme.primary)
                        .withOpacity(0.1),
                    blurRadius: 13,
                    offset: const Offset(0, 1))
              ],
        // borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        width: Get.width,
        child: MaterialButton(
          onPressed: disabled ? null : onPressed,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          color: color ?? Get.theme.colorScheme.primary,
          disabledElevation: 0,
          disabledColor: darkPurpleColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: shadow ? 3 : 0,
          child: Text(text,
              style: Get.textTheme.labelLarge!.copyWith(color: textColor)),
        ),
      ),
    );
  }
}
