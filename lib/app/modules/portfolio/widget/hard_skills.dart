import 'package:flutter/material.dart';

import '../../global_widgets/home_search_bar_widget.dart';

class HardSkills extends StatelessWidget {
  const HardSkills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 20),
      child: Stack(children: [
        HomeSearchBarWidget(),
      ]),
    );
  }
}
