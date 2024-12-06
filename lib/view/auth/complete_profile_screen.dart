import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea/bloc/auth/user_auth_bloc.dart';
import 'package:shoea/main.dart';
import 'package:shoea/util/common_button_widget.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/util/custom_drop_down_widget.dart';
import 'package:shoea/util/snack_bar_widget.dart';
import 'package:shoea/util/spin_kit_show_dialog_widget.dart';
import 'package:shoea/util/text_form_field_widget.dart';
import 'package:shoea/view/bottom_navigation/bottom_navigation_bar_widget.dart';


class CompleteProfileScreen extends StatefulWidget {
  final String email;
  final String uid;
   const CompleteProfileScreen({super.key, required this.email, required this.uid});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
     TextEditingController lastNameController = TextEditingController();
    String selectedGender = "Male";
    String phoneNumber = '';
    final ImagePicker picker = ImagePicker();
    File? image;

    Future<void> pickImage() async {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if(pickedFile != null){
        final File imageFile = File(pickedFile.path);
        setState(() {
          image = imageFile;
        });
        final bytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(bytes);
      }
    }

    Future<String?> _convertImageToBase64()async {
      if(image != null){
        Uint8List imageBytes = await image!.readAsBytes();
        String base64String = base64Encode(imageBytes);
        return base64String;
      }
      return null;
    }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title:const Text("Fill Your Profile"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                    CircleAvatar(
                    radius: 60,
                    backgroundImage: image!= null ? FileImage(image!) :const AssetImage('assets/img/user.png'),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white, size: 20),  
                      onPressed: () {
                        pickImage();
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              CustomTextFormField(controller: firstNameController, hintText: "First name"),
              constantSizedBox(height: 10),
              CustomTextFormField(controller: lastNameController, hintText: "Last name"),
              constantSizedBox(height: 10),
              CustomTextFormField(
                controller: _dateController,
                hintText: "Date of Birth",
                trailing: IconButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        _dateController.text = "${date.day}-${date.month}-${date.year}";
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  icon: const Icon(CupertinoIcons.calendar),
                ),
              ),
              constantSizedBox(height: 10),
              CustomTextFormField(
                controller: phoneController, 
                hintText: "Mobile Number",
                isPhoneNumber: true,
                onInputChanged: (PhoneNumber number) {
                  phoneNumber = number.phoneNumber ?? '';
                },
                ),
              const SizedBox(height: 20),
              CustomDropdownButtonFormField<String>(
                value: selectedGender, 
                onChanged: (value) {
                  selectedGender = value!;
                }, 
                items: const [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
                ]
                ),
              constantSizedBox(height: 15),
              BlocListener<UserAuthBloc , UserAuthState>(
                listener: (context, state) async{
                  if(state is AuthSuccess){
                    final sharedPrefs = await SharedPreferences.getInstance();
                    sharedPrefs.setBool(userAuthKey, true);
                    Navigator.pop(context);
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>const BottomNavigationBarWidget()), (Route<dynamic> route) => false);
                  } else if(state is AuthFailure){
                    Navigator.pop(context);
                    showSnackBarWidget(context, state.error, Colors.red);
                  }
                },
                child:CommonButtonWidget(size: size, buttonText: "Continue", onPressed: () async{
                  String? base64Image = await _convertImageToBase64();
                showDialogSpinkitWidget(context, "Please Wait Saving User Details");
                BlocProvider.of<UserAuthBloc>(context).add(SaveUserDetails(
                  uid: widget.uid, 
                  email: widget.email, 
                  firstname: firstNameController.text.trim(), 
                  lastName: lastNameController.text.trim(), 
                  mobileNum: phoneNumber, 
                  gender: selectedGender, 
                  dateOfBirth: _dateController.text,
                  imageUrl: base64Image,
                  ));
              }) ,
                ),
            ],
          ),
        ),
      ),
    );
  }
}