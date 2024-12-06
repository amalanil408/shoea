import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/view/cart/widgets/model_bottom_sheet_for_delete_cart.dart';
import 'package:shoea/view/checkout/checkout_page_.dart';

class ProductBuilderCartScreenWidget extends StatelessWidget {
  final int itemCount;

  const ProductBuilderCartScreenWidget({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Card(
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
                            image: const DecorationImage(
                              image: AssetImage('assets/img/shoe.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Product name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDeleteBottomSheet(context);
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
                                Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "Black:",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                constantSizedBox(width: 10),
                                const Text("|"),
                                constantSizedBox(width: 10),
                                const Row(
                                  children: [
                                    Text(
                                      "Size =",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '21',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '\$799',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // Decrease
                                          },
                                          icon: const Icon(Icons.remove),
                                        ),
                                        const Text(
                                          '1',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Increase
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total: \$799',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 200,
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const CheckoutPage(itemCount: 8,)));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Checkout"),
                          Icon(Icons.arrow_right_rounded)
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }
}
