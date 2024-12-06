import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoea/bloc/home/home_bloc.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/util/shimmer_effect_widget.dart';
import 'package:shoea/view/offers/offers_screen.dart';
import 'package:shoea/view/wishlist/wishlist_screen.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  String getGreetings() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning 👋";
    } else if (hour < 17) {
      return "Good Afternoon 👋";
    } else {
      return "Good Evening 👋";
    }
  }
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid;

    if (userId != null) {
      context.read<HomeBloc>().add(FetchUserDeatilsInHome(userId: userId));
    }

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is FetchUserDeatilsInHomeLoading || state is HomeInitial) {
          return buildShimmerEffect();
        } else if (state is FetchUserDeatilsInHomeLoaded) {
          return Row(
            children: [
              CircleAvatar(
                backgroundImage: state.imageUrl.isNotEmpty
                    ? MemoryImage(base64Decode(state.imageUrl))
                    : const AssetImage('assets/img/avatar.png') as ImageProvider,
                radius: 25,
              ),
              constantSizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getGreetings(),
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    '${state.firstName} ${state.lastName}',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const OffersScreen()));
                },
                icon: Image.asset(
                  'assets/img/offers.png',
                  width: 25,
                  height: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>const WishlistScreen()));
                },
                icon: Image.asset(
                  'assets/img/wishlist.png',
                  width: 25,
                  height: 50,
                ),
              ),
            ],
          );
        } else if (state is FetchUserDeatilsInHomeError) {
          return Text(
            "Error: ${state.error}",
            style: const TextStyle(color: Colors.red),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
