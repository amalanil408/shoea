import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/view/orders/widgets/active_screen_widget.dart';
import 'package:shoea/view/orders/widgets/complete_order_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/img/com_logo.jpg',
                width: 70,
                height: 70,
              ),
              Text(
                "My Orders",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.black, width: 2.5),
                insets: EdgeInsets.symmetric(horizontal: 96)),
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: "Active",
              ),
              Tab(
                text: "Completed",
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: const TabBarView(
          children: [
            ActiveScreenWidget(itemCount: 8),
            CompleteOrderWidget(itemCount: 8)
          ],
        ),
      ),
    );
  }
}
