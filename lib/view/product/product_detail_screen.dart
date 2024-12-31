import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/Cart/cart_bloc.dart';
import 'package:shoea/view/product/widget/description_widget.dart';
import 'package:shoea/view/product/widget/image_length_position_widget.dart';
import 'package:shoea/view/product/widget/preview_image.dart';
import 'package:shoea/view/product/widget/product_name_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  int selectedVariantIndex = 0;
  int currentImageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      context.read<CartBloc>().add(CheckIfInWishlist(
          userId: userId, productId: widget.product['product_id']));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool isInWishlist = false;
  @override
  Widget build(BuildContext context) {
    final List<dynamic> variants = widget.product['variants'] ?? [];
    final String productName =
        widget.product['product_name'] ?? 'Unknown Product';
    final String productDescription =
        widget.product['product_description'] ?? 'No description available';
    final List<String> images = variants.isNotEmpty
        ? List<String>.from(variants[selectedVariantIndex]['images'] ?? [])
        : [];
    final String basePriceString = widget.product['final_price'] ?? '0.0';
    final String discountPercentageString =
        widget.product['discount_percentage'] ?? '0.0';
    double basePrice = double.tryParse(basePriceString) ?? 0.0;
    double discountPercentage =
        double.tryParse(discountPercentageString) ?? 0.0;
    double finalPrice = basePrice - (basePrice * (discountPercentage / 100));
    final double totalAmount = finalPrice * quantity;

    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if(state is WishlistStatus){
            setState(() {
              isInWishlist = state.isInWishlist;
            });
          }
          if(state is WishlistUpdated){
            final userId = FirebaseAuth.instance.currentUser?.uid;
            if(userId != null){
              context.read<CartBloc>().add(CheckIfInWishlist(userId: userId, productId: widget.product['product_id']));
            }
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (images.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FullScreenImagePreview(images: images),
                            ),
                          );
                        }
                      },
                      child: SizedBox(
                        height: 300,
                        child: images.isNotEmpty
                            ? PageView.builder(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    currentImageIndex = index;
                                  });
                                },
                                itemCount: images.length,
                                itemBuilder: (context, index) {
                                  return Image.memory(
                                    base64Decode(images[index]),
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : const Center(child: Text("No Images Available")),
                      ),
                    ),
                    if (images.isNotEmpty)
                      ImageLengthPositonWidget(
                          currentImageIndex: currentImageIndex, images: images),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: Image.asset(
                          isInWishlist ? 'assets/img/like.png' :
                          'assets/img/unlike.png',
                          width: 40,
                          height: 40,
                        ),
                        onPressed: () {
                          final userId = FirebaseAuth.instance.currentUser?.uid;
                          if(userId != null){
                            if(isInWishlist){
                              context.read<CartBloc>().add(RemoveFromWishlist(userId: userId, productId: widget.product['product_id']));
                            } else {
                              context.read<CartBloc>().add(AddToWishlist(userId: userId, productId: widget.product['product_id']));
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ProductNameWidget(productName: productName),
                const SizedBox(height: 8),
                DescriptionWidget(productDescription: productDescription),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Available Colors:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                variants.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(variants.length, (index) {
                            String color = variants[index]['color'];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedVariantIndex = index;
                                  currentImageIndex = 0;
                                  _pageController.jumpToPage(0);
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedVariantIndex == index
                                        ? Colors.black
                                        : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Color(int.parse('0x$color')),
                                  radius: 15,
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    : const Center(child: Text("No Variants Available")),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      "Quantity",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                        ),
                        onPressed: () {
                          final userId = FirebaseAuth.instance.currentUser?.uid;
                          final productId = widget.product['product_id'];
                          context.read<CartBloc>().add(
                              AddToCart(userId: userId!, productId: productId));
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
