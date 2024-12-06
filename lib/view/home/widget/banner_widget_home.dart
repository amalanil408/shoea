import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/view/offers/offers_screen.dart';

class BannerWidgetHomeScreen extends StatelessWidget {
  const BannerWidgetHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Special Offers", style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5
            ),),
            TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const OffersScreen()));
              }, 
              child:  Text("See All",style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),))
          ],
        ),
        SizedBox(
          height: 170,
          width: size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset('assets/img/ban.jpg'))
          )
      ],
    );
  }
}