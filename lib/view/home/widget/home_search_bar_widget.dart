import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: InkWell(
        onTap: () {
          
        },
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
              prefixIcon: const Icon(CupertinoIcons.search,color: Colors.grey,),
              suffixIcon: IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.slider_horizontal_3,color: Colors.grey,)
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15)
            ),
          ),
        ),
      ),
    );
  }
}