import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/ui.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class DropdownWidget extends StatelessWidget {
  const DropdownWidget(
      {Key? key, required this.items, this.suffixIcon, this.hint})
      : super(key: key);
  final List<DropdownMenuItem> items;
  final Widget? suffixIcon;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: DropdownButtonFormField(
        hint: Text(
          "${hint}",
          style: TextStyle(
              fontWeight: FontWeight.normal, color: Colors.grey.shade500),
        ),
        icon: suffixIcon,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: lightGrayColor, width: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: lightGrayColor, width: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: lightGrayColor,
        ),
        style: Get.textTheme.bodyMedium,
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          // print(value);
        },
      ),
    );
  }
}
