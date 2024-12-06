import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/view/wishlist/widget/product_grid_widget_wishlist.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("My Wishlist",style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
          letterSpacing: 1
        ),),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.search))
        ],
      ),
      body: const SingleChildScrollView(
        child: ProductGridWidgetWishlist(itemCount: 5)
        ),
    );
  }
}