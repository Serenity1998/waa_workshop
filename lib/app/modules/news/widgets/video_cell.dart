import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controllers/news_controller.dart';

class VideoCell extends GetWidget<NewsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 26, top: 37),
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://a.cdn-hotels.com/gdcs/production33/d1957/3dca8448-04b8-41f7-9484-831ee08e0f53.jpg?impolicy=fcrop&w=800&h=533&q=medium"),
                        Image.asset(
                          "assets/img_new/ic_video.png",
                          width: 17,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, right: 16),
                    width: 120,
                    child: Column(
                      children: [
                        Text(
                          "Шинэ жилийн хямдрал!",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img_new/ic_eye.png",
                              width: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '40,999',
                              style: TextStyle(color: Color(0xff9397A0)),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
