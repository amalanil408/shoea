import 'dart:convert'; 
import 'dart:typed_data'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shoea/bloc/Wishlist/wishlist_bloc.dart';
import 'package:shoea/view/product/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final String userId;

  const ProductCard({super.key, required this.product, required this.userId});

  Uint8List? decodeBase64Image(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    return base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes = decodeBase64Image(product['variants'][0]['images'][0]);
    String? imageUrl = product['image'];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ProductDetailScreen(product: product),
                  ));
                },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Colors.grey[200],
                    image: imageBytes != null
                        ? DecorationImage(
                            image: MemoryImage(imageBytes),
                            fit: BoxFit.cover,
                          )
                        : (imageUrl != null && imageUrl.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              )
                            : null),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    context.read<WishlistBloc>().add(
                          AddToWishlist(
                            userId: userId,
                            productId: product['product_id'],
                          ),
                        );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product['product_name'] ?? '',
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
              itemBuilder: (context, index) =>
                  const Icon(Icons.star, color: Colors.black),
              itemCount: 5,
              itemSize: 18,
              unratedColor: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${product['final_price'] ?? '0.00'}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
