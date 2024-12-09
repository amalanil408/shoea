import 'package:flutter/material.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/view/home/widget/banner_widget_home.dart';
import 'package:shoea/view/home/widget/home_header_widget.dart';
import 'package:shoea/view/home/widget/home_search_bar_widget.dart';
import 'package:shoea/view/home/widget/product_brand_button_widget_home.dart';
import 'package:shoea/view/home/widget/product_brand_circle_avatar.dart';
import 'package:shoea/view/home/widget/product_grid_widget_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeaderWidget(),
              constantSizedBox(height: 5),
              HomeSearchBarWidget(size: size),
              const BannerWidgetHomeScreen(),
              constantSizedBox(height: 5),
              const ProductBrandCircleAvatar(),
              const ProductBrandButtonWidgetHome(count: 4),
              constantSizedBox(height: 5),
              const ProductGridWidgetHome(itemCount: 7)
            ],
          ),
        ),
      ),
    );
  }
}