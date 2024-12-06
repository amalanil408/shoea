import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarCartWidget extends StatelessWidget {
  const AppBarCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Row(
      children: [
        Image.asset('assets/img/com_logo.jpg',width: 70,height: 70,),
        Text(
          "My Cart",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
      )
    ],
    );
  }
}