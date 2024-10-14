import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controllers/news_controller.dart';

class NewsCell extends GetWidget<NewsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 304,
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 26, top: 0),
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.NEWSDETAIL);
              },
              child: Container(
                margin: EdgeInsets.only(right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                          width: 231,
                          height: 164,
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://a.cdn-hotels.com/gdcs/production33/d1957/3dca8448-04b8-41f7-9484-831ee08e0f53.jpg?impolicy=fcrop&w=800&h=533&q=medium"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 0, right: 16, top: 18),
                      width: 255,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Зуны амралтаа Малдив арал дээр өнгөрүүлээрэй!",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                    width: 38,
                                    height: 38,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3WEmfJCME77ZGymWrlJkXRv5bWg9QQmQEzw&usqp=CAU"),
                              ),
                              Container(
                                width: 130,
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('“Ami Travel” ХХК'),
                                    Text(
                                      'Sep 9, 2022',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0XFF9397A0)),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 37,
                                height: 37,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/img_new/ic_send.png",
                                      width: 16,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffEFF5F4)),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }
}
