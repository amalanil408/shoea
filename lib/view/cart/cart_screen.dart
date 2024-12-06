import 'package:flutter/material.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/view/cart/widgets/app_bar_cart_widgtes.dart';
import 'package:shoea/view/cart/widgets/product_builder_cart_screen_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scaffoldBackGroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBarCartWidget()),
        body: ProductBuilderCartScreenWidget(itemCount: 5),
    );
  }
}


