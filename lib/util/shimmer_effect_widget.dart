import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoea/util/constant.dart';

Widget buildShimmerEffect() {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 25,
          ),
        ),
        constantSizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 100,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 150,
                height: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const Spacer(),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 25,
            height: 50,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 16),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 25,
            height: 50,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }