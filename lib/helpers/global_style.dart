import 'package:flutter/material.dart';

class GlobalStyle {
  static gGradiant(colorOne, colorTwo) {
    return LinearGradient(
      colors: [
        colorOne,
        colorTwo,
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: const [0, 1],
      tileMode: TileMode.decal,
    );
  }
  // static LinearGradient gGradientPrimary = LinearGradient(
  //   colors: [
  //     CoreColor.primary,
  //     CoreColor.primaryLight,
  //   ],
  //   begin: Alignment.bottomLeft,
  //   end: Alignment.topRight,
  //   stops: const [0, 1],
  //   tileMode: TileMode.decal,
  // );

//  LinearGradient(
//                           colors: [
//                             CoreColor.b1,
//                             CoreColor.b2,
//                           ],
//                           begin: Alignment.bottomLeft,
//                           end: Alignment.topRight,
//                           stops: const [0, 1],
//                           tileMode: TileMode.decal,
//                         ),
}
