import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.productDescription,
  });

  final String productDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Description",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),),
          const SizedBox(height: 5,),
          Text(
        productDescription,
        style: const TextStyle(fontSize: 16),
      ),
        ],
      )
    );
  }
}