import 'package:flutter/material.dart';

class ProductBrandCircleAvatar extends StatelessWidget {
  final int count;
  const ProductBrandCircleAvatar({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    int avatarCount = count > 8 ? 8 : count;

    List<Widget> avatars = List.generate(avatarCount, (index) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 50, 
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                ),
                ClipOval(
                  child: Image.asset(
                    'assets/img/adidas.png',
                    width: 40, 
                    height: 30, 
                    fit: BoxFit.contain, 
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Brand ${index + 1}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    });

    return Column(
      children: List.generate(
        (avatarCount / 4).ceil(),
        (rowIndex) {
          int startIndex = rowIndex * 4;
          int endIndex = startIndex + 4;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: avatars.sublist(
                  startIndex, endIndex > avatarCount ? avatarCount : endIndex),
            ),
          );
        },
      ),
    );
  }
}
