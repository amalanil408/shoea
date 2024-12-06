import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/util/constant.dart';

class CommonButtonWidget extends StatelessWidget {
  const CommonButtonWidget({
    super.key,
    required this.size, required this.buttonText, required this.onPressed,
  });

  final Size size;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10),
      child: SizedBox(
        height: 60,
        width: size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBackGroundColor
          ),
          onPressed: onPressed, 
          child:  Text(buttonText,
          style: GoogleFonts.roboto(
            color: buttonForGroundColor,
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
          )
          ),
      ),
    );
  }
}