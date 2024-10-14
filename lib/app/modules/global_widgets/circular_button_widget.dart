import 'package:flutter/material.dart';

class CircularButtonWidget extends StatelessWidget {
  const CircularButtonWidget({Key? key, this.color, this.icon, this.onPressed})
      : super(key: key);
  final Color? color;
  final Widget? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        height: 58,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: this.color,
        ),
        child: this.icon,
      ),
    );
  }
}
