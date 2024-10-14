import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../providers/laravel_provider.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/home_search_bar_widget.dart';
import '../../global_widgets/main_appbar.dart';
import '../controllers/categories_controller.dart';
import '../widgets/category_grid_item_widget.dart';
import '../widgets/category_list_item_widget.dart';

class CategoriesView extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            MainAppBar(title: "Categories of services".tr, centerTitle: true),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<LaravelApiClient>().forceRefresh();
            controller.refreshCategories(showMessage: true);
            Get.find<LaravelApiClient>().unForceRefresh();
          },
          child: ListView(
            primary: true,
            children: [
              HomeSearchBarWidget(),
              const SizedBox(height: 10),
              Obx(() {
                return Offstage(
                  offstage: controller.layout.value != CategoriesLayout.GRID,
                  child: controller.categories.isEmpty
                      ? CircularLoadingWidget(height: 400)
                      : MasonryGridView.count(
                          primary: false,
                          shrinkWrap: true,
                          crossAxisCount: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 2
                              : 4,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          itemCount: controller.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryGridItemWidget(
                                category:
                                    controller.categories.elementAt(index),
                                heroTag: "heroTag");
                          },
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                        ),
                );
              }),
              Obx(() {
                return Offstage(
                  offstage: controller.layout.value != CategoriesLayout.LIST,
                  child: controller.categories.isEmpty
                      ? CircularLoadingWidget(height: 400)
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.categories.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            return CategoryListItemWidget(
                              heroTag: 'category_list',
                              expanded: index == 0,
                              category: controller.categories.elementAt(index),
                            );
                          },
                        ),
                );
              }),
              // Container(
              //   child: ListView(
              //       primary: false,
              //       shrinkWrap: true,
              //       children: List.generate(controller.categories.length, (index) {
              //         return Obx(() {
              //           var _category = controller.categories.elementAt(index);
              //           return Padding(
              //             padding: const EdgeInsetsDirectional.only(start: 20),
              //             child: Text(_category.name),
              //           );
              //         });
              //       })),
              // ),
            ],
          ),
        ));
  }
}
