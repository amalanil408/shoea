import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/view/offers/widget/offers_builder_widget.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Offers",style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
          letterSpacing: 1
        ),),
      ),
      body: const OffersBuilderWidget(itemCount: 4),
    );
  }
}