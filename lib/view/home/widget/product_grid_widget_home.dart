import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shoea/bloc/home/home_bloc.dart';
import 'package:shoea/view/product/product_detail_screen.dart';

class ProductGridWidgetHome extends StatelessWidget {
  const ProductGridWidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeWishlistAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wishlist updated successfully')),
          );
        } else if (state is HomeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeError) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is HomeLoaded) {
          final product = state.products;
          final wishlist = state.wishlist;
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    String? base64Image = product[index]['image'];
                    ImageProvider imageProvider;
                    if (base64Image != null && base64Image.isNotEmpty) {
                      imageProvider = MemoryImage(base64Decode(base64Image));
                    } else {
                      imageProvider = const AssetImage('assets/img/shoe.jpg');
                    }

                    bool isInWishlist = wishlist.contains(product[index]['product_id']);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ProductDetailScreen(
                              product: product[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.grey[200],
                                  ),
                                ),
                                Positioned(
                                  top: -4,
                                  right: -8,
                                  child: IconButton(
                                    icon: Image.asset(
                                      isInWishlist
                                          ? 'assets/img/like.png'
                                          : 'assets/img/unlike.png',
                                      width: 40,
                                      height: 30,
                                    ),
                                    onPressed: () {
                                      final userId = FirebaseAuth.instance.currentUser?.uid;
                                      final productId = product[index]['product_id'];
                                      if (productId != null && userId != null) {
                                        context.read<HomeBloc>().add(AddToWishlist(
                                              userId: userId,
                                              productId: productId,
                                            ));
                                      } else {
                                        print("ID is null");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                product[index]['product_name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RatingBarIndicator(
                                rating: 4.5,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.black,
                                ),
                                itemCount: 5,
                                itemSize: 18,
                                unratedColor: Colors.grey.shade300,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '\$${product[index]['final_price']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(child: Text("No data available"));
      },
    );
  }
}
