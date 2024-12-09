import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/account/account_bloc.dart';
import 'package:shoea/util/text_form_field_widget.dart';
import 'package:shoea/view/account/widgets/update_user_details_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      context.read<AccountBloc>().add(FetchUserDetails(userId: currentUser.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is UpdateUserDetailsLoaded) {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              context.read<AccountBloc>().add(FetchUserDetails(userId: currentUser.uid));
            }
          } else if (state is UpdateUserDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is FetchUserDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchUserDetailsLoaded) {
              return _buildProfileDetails(context, state);
            } else if (state is FetchUserDetailsError) {
              return Center(
                child: Text(
                  "Error: ${state.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context, FetchUserDetailsLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: state.imageUrl.isNotEmpty
                ? MemoryImage(base64Decode(state.imageUrl))
                : const AssetImage('assets/img/like.png') as ImageProvider,
            child: const Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildReadOnlyField(state.firstName),
          _buildReadOnlyField(state.lastName),
          _buildReadOnlyField(state.email),
          _buildReadOnlyField(state.mobileNum),
          _buildReadOnlyField(state.gender),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showUpdateDialog(
                context,
                state.firstName,
                state.lastName,
                state.email,
                state.mobileNum,
                state.gender,
                FirebaseAuth.instance.currentUser?.uid,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Update Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String value) {
    return Column(
      children: [
        CustomTextFormField(
          controller: TextEditingController(text: value),
          hintText: value,
          readOnly: true,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
