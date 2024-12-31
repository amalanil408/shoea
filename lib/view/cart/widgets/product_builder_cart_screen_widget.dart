import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/view/cart/widgets/model_bottom_sheet_for_delete_cart.dart';
import 'package:shoea/view/product/product_detail_screen.dart';
import '../../../bloc/Cart/cart_bloc.dart';

class ProductBuilderCartScreenWidget extends StatelessWidget {
  const ProductBuilderCartScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return BlocProvider(
      create: (context) => CartBloc()..add(FetchCart(userId: userId!)),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text('Your cart is empty.'));
            }
            final totalPrice = state.products.fold<double>(
              0.0,
              (sum, product) =>
                  sum + (double.tryParse(product['final_price'] ?? '0') ?? 0.0),
            );

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      final String productName =
                          product['product_name'] ?? 'Unknown Product';
                      final String imageUrl = product['variants'][0]['images'][0] ?? '';
                      final double finalPrice =
                          double.tryParse(product['final_price'] ?? '0') ?? 0;

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ProductDetailScreen(product: product)));
                        },
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 3,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: imageUrl.isNotEmpty
                                      ? Image.memory(
                                          base64Decode(imageUrl),
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.image_not_supported,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            productName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            print(userId);
                                            showDeleteBottomSheet(context, product['product_id'], userId!, productName, imageUrl);
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.delete,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          'Price: \$${finalPrice.toStringAsFixed(2)}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          'Total: \$${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            onPressed: () {
                              // Navigate to checkout
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Checkout"),
                                Icon(Icons.arrow_right_rounded)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
