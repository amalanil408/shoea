import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWithMobileWidget extends StatelessWidget {
  const LoginWithMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/mobile.png',height: 24,width: 24,),
            const SizedBox(width: 20,),
            Text('Continue with Mobile',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            )
          ],
        ),
      ),
    );
  }
}