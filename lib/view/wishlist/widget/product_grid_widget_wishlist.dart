import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/Wishlist/wishlist_bloc.dart';
import 'package:shoea/view/wishlist/widget/product_card_widget.dart';

class ProductGridWidgetWishlist extends StatelessWidget {
  final String userId;

  const ProductGridWidgetWishlist({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistBloc()..add(FetchWishlist(userId: userId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Wishlist"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WishlistError) {
              return Center(child: Text(state.message));
            } else if (state is WishlistLoaded) {
              final products = state.products;
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    userId: userId,
                  );
                },
              );
            }
            return const Center(child: Text("No items in wishlist"));
          },
        ),
      ),
    );
  }
}

