import 'package:flutter/material.dart';

class OffersBuilderWidget extends StatelessWidget {
  final int itemCount; 
  final Function(int index)? onTap; 

  const OffersBuilderWidget({
    super.key,
    required this.itemCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onTap?.call(index), 
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/img/ban.jpg'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
