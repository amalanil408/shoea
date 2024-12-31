import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoea/view/search/search_screen.dart';
import 'package:shoea/view/sort/sort_screen.dart';

class HomeSearchBarWidget extends StatelessWidget {
  const HomeSearchBarWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width:size.width,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15)
        ),
        child:  TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: InputBorder.none,
            prefixIcon: IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const SearchScreen()));
            }, icon: const Icon(CupertinoIcons.search)),
            suffixIcon: IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const SortScreen()));
            }, icon: const Icon(CupertinoIcons.slider_horizontal_3,color: Colors.grey,)
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15)
          ),
        ),
      ),
    );
  }
}