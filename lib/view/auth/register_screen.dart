import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea/bloc/auth/user_auth_bloc.dart';
import 'package:shoea/main.dart';
import 'package:shoea/util/common_button_widget.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/util/snack_bar_widget.dart';
import 'package:shoea/util/spin_kit_show_dialog_widget.dart';
import 'package:shoea/util/text_form_field_widget.dart';
import 'package:shoea/view/auth/complete_profile_screen.dart';
import 'package:shoea/view/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
   const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    final TextEditingController emailController = TextEditingController();

    final TextEditingController passwordController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBackGroundColor,
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,shadowColor: Colors.transparent,),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Image.asset('assets/img/com_logo.jpg',height: 150,)),
                Text('Create Your Account',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                ),
                constantSizedBox(height: 10),
                CustomTextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Email is required";
                    } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  controller: emailController, 
                  hintText: 'Email',
                  leading:const Icon(CupertinoIcons.mail_solid,color: Colors.grey,),
                  ),
                constantSizedBox(height: 5),
                CustomTextFormField(
                  obscureText: obscureText,
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Enter password";
                    }
                    return null;
                  },
                  controller: passwordController, 
                  hintText: 'Password',
                leading:const Icon(CupertinoIcons.lock,color: Colors.grey,),
                trailing: IconButton(onPressed: (){
                  setState(() {
                    obscureText = !obscureText;
                  });
                }, icon:  Icon(obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash_fill,color: Colors.grey,)),
                ),
                constantSizedBox(height: 20),
                BlocListener<UserAuthBloc , UserAuthState>(
                  listener: (context, state) {
                    if(state is AuthSuccess){
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => CompleteProfileScreen(email: emailController.text.trim(),uid: FirebaseAuth.instance.currentUser!.uid,)));
                    } else if(state is AuthFailure){
                      Navigator.pop(context);
                      showSnackBarWidget(context, state.error, Colors.red);
                    }
                  },
                  child: CommonButtonWidget(size: size, buttonText: 'Sign up', 
                  onPressed: (){
                  if(formKey.currentState!.validate()){
                    showDialogSpinkitWidget(context, "Registering Please Wait");
                    BlocProvider.of<UserAuthBloc>(context).add(SignUpRequested(email: emailController.text.trim(), password: passwordController.text.trim()));
                  }
                }
                ),
                  ),
                constantSizedBox(height: 10),
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",style: TextStyle(color: Colors.grey),),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => LoginScreen()));
                }, child: const Text("Sign up",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
              ],
            )
              ],
            ),
          ),
        ),
      ),
    );
  }
}