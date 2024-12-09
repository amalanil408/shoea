import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/bloc/account/account_bloc.dart';
import 'package:shoea/view/account/edit_profile_screen.dart';
import 'package:shoea/view/account/widgets/account_item_widgets.dart';
import 'package:shoea/view/account/widgets/model_sheet_logout.dart';
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid;

    if (userId != null) {
      context
          .read<AccountBloc>()
          .add(FetchUserDetailsInAccount(userId: userId));
    }
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/img/com_logo.jpg',
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 10),
              Text(
                "Profile",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is FetchUserDetailsInAccountLoading) {
              return const CircularProgressIndicator();
            } else if (state is FetchUserDetailsInAccountLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: state.imageUrl.isNotEmpty ? MemoryImage(base64Decode(state.imageUrl)) : const AssetImage('assets/img/avatar.png'),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${state.firstName} ${state.lastName}",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      state.mobileNum,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        buildAccountItem(
                          context,
                          icon: Icons.account_circle_outlined,
                          title: "Edit Profile",
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  const EditProfileScreen()));
                          },
                        ),
                        buildAccountItem(
                          context,
                          icon: Icons.location_on_outlined,
                          title: "Address",
                          onTap: () {},
                        ),
                        buildAccountItem(
                          context,
                          icon: Icons.lock_outline_rounded,
                          title: "Privacy and Policy",
                          onTap: () {},
                        ),
                        buildAccountItem(
                          context,
                          icon: Icons.info_outline,
                          title: "Help Center",
                          onTap: () {},
                        ),
                        buildAccountItem(
                          context,
                          icon: Icons.logout,
                          title: "Logout",
                          onTap: () async{
                            showLogoutConfirmation(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is FetchUserDetailsInAccountError) {
              return Text(
                "Error: ${state.error}",
                style: const TextStyle(color: Colors.red),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}

