import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? centerTitle;
  final Function()? onTap;
  final List<Widget>? actions;
  const MainAppBar({
    Key? key,
    this.title,
    this.centerTitle = false,
    this.onTap,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "$title",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: actions,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Get.theme.primaryColor.withOpacity(0.5),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, size: 22, color: Get.theme.hintColor),
          onPressed: onTap ?? Get.back,
        ),
      ),
      leadingWidth: 50,
    );
  }
}
