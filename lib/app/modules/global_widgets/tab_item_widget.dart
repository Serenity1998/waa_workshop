import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabItemWidget extends StatelessWidget {
  final Function? onTap;
  final String? name;
  final bool selected;
  final double? ratio;

  const TabItemWidget(
      {Key? key, this.onTap, this.name, required this.selected, this.ratio = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!(),
      child: Container(
        height: 44,
        width: ratio,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: selected ? 2 : 1,
                    color:
                        selected ? Get.theme.focusColor : Colors.grey[300]!))),
        child: Center(
            child: Text(
          "${name}",
          style: Get.textTheme.bodyMedium?.merge(
              TextStyle(color: selected ? Get.theme.focusColor : Colors.grey)),
        )),
      ),
    );
  }
}
