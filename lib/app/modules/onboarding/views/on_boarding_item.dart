import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingItem extends StatelessWidget {
  final String? info;
  final String? image;

  const OnboardingItem({Key? key, this.info, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.height * 0.6,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  "assets/img_new/onboarding_back.png",
                  fit: BoxFit.contain,
                  scale: 1.3,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/img_new/${image}.png",
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Text(
            "${info}",
            style: Get.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
