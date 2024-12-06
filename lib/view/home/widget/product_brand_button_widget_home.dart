import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductBrandButtonWidgetHome extends StatefulWidget {
  final int count;
  const ProductBrandButtonWidgetHome({super.key, required this.count});

  @override
  State<ProductBrandButtonWidgetHome> createState() => _ProductBrandButtonWidgetHomeState();
}

class _ProductBrandButtonWidgetHomeState extends State<ProductBrandButtonWidgetHome> {
  int? selectedButtonIndex;
  final List<String> productBrandName = [
    "All",
    "Nike",
    "Adidas",
    "Puma"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text("Most Popular", style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              letterSpacing: 1
             ),),
            TextButton(
              onPressed: () {},
              child:  Text("See All",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, 
          child: Row(
            children: List.generate(widget.count, (index) {
              bool isSelected = selectedButtonIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.black : Colors.white,
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      side: isSelected
                          ? const BorderSide(color: Colors.transparent, width: 0)
                          : const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = index;
                    });
                  },
                  child: Text(productBrandName[index]),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
