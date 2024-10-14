import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';

class NewsDetail extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 350.0,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Container(
                  height: 100,
                  width: Get.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Text(
                      'Зуны амралтаа Малдив арал дээр өнгөрүүлээрэй!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                )),
            flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Зуны амралтаа Малдив арал дээр өнгөрүүлээрэй!',
                  style: TextStyle(fontSize: 0, fontWeight: FontWeight.w500),
                ),
                background: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl:
                        "https://a.cdn-hotels.com/gdcs/production33/d1957/3dca8448-04b8-41f7-9484-831ee08e0f53.jpg?impolicy=fcrop&w=800&h=533&q=medium")),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return Container(
                  height: 54,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        child: CachedNetworkImage(
                          height: 26,
                          width: 26,
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://a.cdn-hotels.com/gdcs/production33/d1957/3dca8448-04b8-41f7-9484-831ee08e0f53.jpg?impolicy=fcrop&w=800&h=533&q=medium",
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 2),
                        child: Text('“Ami Travel” ХХК',
                            style: Get.textTheme.bodySmall?.merge(TextStyle(
                                color: Color(0xff9397A0), fontSize: 12))),
                      ),
                      Text('May 17',
                          style: Get.textTheme.bodySmall?.merge(TextStyle(
                              color: Color(0xff9397A0), fontSize: 12))),
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xff9397A0)),
                      ),
                      Text('8 min read',
                          style: Get.textTheme.bodySmall?.merge(TextStyle(
                              color: Color(0xff9397A0), fontSize: 12)))
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: Color(0xffEEEEEE))),
                );
              },
              childCount: 1,
            ),
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Text(
                      'Just say anything, George, say what evers natural, the first thing that comes to your mind. Take that you mutated son-of-a-bitch.My pine, why you. You space bastard, you killed a pine. You do? Yeah, its 8:00. Hey, McFly, I thought I told you never Just say anything, George, say what evers natural, the first thing that comes to your mind. Take that you mutated son-of-a-bitch. My pine, why you. You space bastard, you killed a pine. You do? Yeah, its 8:00. Hey, McFly, I thought I told you never ',
                      style: Get.textTheme.headlineMedium?.merge(TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          height: 1.5))),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
