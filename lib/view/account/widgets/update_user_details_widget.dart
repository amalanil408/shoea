import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/account/account_bloc.dart';
import 'package:shoea/util/text_form_field_widget.dart';

void showUpdateDialog(
  BuildContext context,
  String firstName,
  String lastName,
  String email,
  String mobile,
  String gender,
  String? userId
) {
  final TextEditingController firstNameController =
      TextEditingController(text: firstName);
  final TextEditingController lastNameController =
      TextEditingController(text: lastName);
  final TextEditingController emailController =
      TextEditingController(text: email);
  final TextEditingController mobileController =
      TextEditingController(text: mobile);
  final TextEditingController genderController =
      TextEditingController(text: gender);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Update Profile'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                controller: firstNameController,
                hintText: 'First Name',
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: lastNameController,
                hintText: 'Last Name',
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: mobileController,
                hintText: 'Mobile Number',
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: genderController,
                hintText: 'Gender',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AccountBloc>().add(UpdateUserDetails(
                userId: userId!, 
                firstName: firstNameController.text.trim(), 
                lastName: lastNameController.text.trim(), 
                gender: genderController.text.trim(), 
                mobileNum: mobileController.text.trim()
                ));
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      );
    },
  );
}
