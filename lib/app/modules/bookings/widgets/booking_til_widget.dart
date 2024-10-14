/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';

import '../../../../common/ui.dart';

// ignore: must_be_immutable
class BookingTilWidget extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final double? horizontalPadding;
  BoxDecoration? decoration;

  BookingTilWidget(
      {Key? key,
      this.title,
      this.content,
      this.actions,
      this.horizontalPadding,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.decoration == null) {
      decoration = Ui.getBoxDecoration();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 20, vertical: 15),
      decoration: decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: title ?? SizedBox()),
              if (actions != null)
                Wrap(
                  children: actions!,
                )
            ],
          ),
          Divider(
            height: 26,
            thickness: 1.2,
          ),
          content ?? SizedBox(),
        ],
      ),
    );
  }
}
