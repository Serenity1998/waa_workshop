import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class NewsListItemWidget extends StatelessWidget {
  const NewsListItemWidget({Key? key, this.news, required this.index})
      : super(key: key);
  final dynamic news;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.NEWS_DETAILS, arguments: news);
      },
      child: Container(
        // color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     color: Colors.grey.withOpacity(0.1),
                    //     border: Border.all(width: 0.5, color: Colors.black12)),
                    // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      news['topic'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    news['description'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    news['introduction'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  SizedBox(height: 5),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(news['reporter'],
                          style:
                              TextStyle(fontSize: 10, color: Colors.black87)),
                      SizedBox(width: 20),
                      Text(
                        news['createdAt'],
                        style: TextStyle(fontSize: 10, color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icon/love.png',
                            height: 13,
                            width: 13,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('11',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black87)),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icon/comment.png',
                            height: 13,
                            width: 13,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('28 replies',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black87)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: 10),
            // Container(
            //   width: 100,
            //   height: 100,
            //   clipBehavior: Clip.hardEdge,
            //   decoration:
            //       BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //   child: Image.network(news['imageUrl'], fit: BoxFit.cover),
            // ),
          ],
        ),
      ),
    );
  }
}
