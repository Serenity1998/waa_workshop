import 'package:flutter/material.dart';

import '../../../../common/ui.dart';

class PortolioItemWidget extends StatelessWidget {
  const PortolioItemWidget({
    Key? key,
    this.title,
    this.type,
    this.secondary,
    this.primary,
  }) : super(key: key);
  final String? title;
  final String? type;
  final String? secondary;
  final String? primary;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      padding: EdgeInsets.only(left: 20),
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: lightGrayColor,
      ),
      // padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              child: Text(
                "${title}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff9E9E9E),
                ),
              ),
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              if (secondary != null)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color.fromARGB(75, 74, 222, 128),
                  ),
                  padding:
                      EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 6),
                  child: Text(
                    "${secondary}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff4AAF57),
                    ),
                  ),
                ),
              SizedBox(
                width: 10,
              ),
              if (primary != null)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color.fromARGB(75, 116, 16, 255)),
                  padding:
                      EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 6),
                  child: Text(
                    "${primary}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff7210FF),
                    ),
                  ),
                ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  // Get.toNamed(Routes.PORTFOLIO_EDUCATION_CREATE);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff7210FF),
                  ),
                  child: Image.asset(
                    "assets/img_new/ic_edit_line.png",
                    width: 18,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
