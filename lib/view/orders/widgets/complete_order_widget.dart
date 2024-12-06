import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/util/constant.dart';

class CompleteOrderWidget extends StatelessWidget {
  final int itemCount;
  const CompleteOrderWidget({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                                  "Product name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                            Container(
                              width: 70,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child:  Center(child: Text("Completed",style: GoogleFonts.roboto(
                                fontSize: 10
                              ),),),
                            ),
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
                                    height: 40,
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: TextButton(onPressed: (){}, child:  Text("Leave Review",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white
                                    ),
                                    ))
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
            );
  }
}