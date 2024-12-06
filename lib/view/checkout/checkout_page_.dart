import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/view/checkout/widgets/addres_section_checkout_widget.dart';
import 'package:shoea/view/checkout/widgets/continue_to_payment_button_widget.dart';
import 'package:shoea/view/checkout/widgets/order_list_ckeckout_widget.dart';

class CheckoutPage extends StatelessWidget {
  final int itemCount;

  const CheckoutPage({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Shipping Address",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const AddresSectionCheckoutWidget(),
          const Divider(thickness: 1.5),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Order List",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: OrderListWidgetCheckout(itemCount: itemCount),
          ),
        ],
      ),
      bottomNavigationBar: const ContinueToPayementButonCheckout(),
    );
  }
}

