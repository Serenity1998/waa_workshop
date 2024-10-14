import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class PortfolioLanguageWidget extends StatelessWidget {
  const PortfolioLanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: 16.0,
            right: 26.0,
            child: FloatingActionButton(
              onPressed: () => {Get.toNamed(Routes.PORTFOLIO_LANGUAGE_CREATE)},
              child: Icon(Icons.add),
              backgroundColor: Color(0xff7210FF),
            ),
          )
        ],
      ),
    );
  }
}
