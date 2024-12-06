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
import 'package:shoea/view/auth/register_screen.dart';
import 'package:shoea/view/bottom_navigation/bottom_navigation_bar_widget.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                Text('Login To Your Account',
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
                  listener: (context, state) async{
                    if(state is AuthSuccess){
                      Navigator.pop(context);
                      final sharedPrefs = await SharedPreferences.getInstance();
                      sharedPrefs.setBool(userAuthKey, true);
                      showSnackBarWidget(context, state.message, Colors.green);
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => const BottomNavigationBarWidget()), (Route<dynamic> route)=> false);
                    } else if(state is AuthFailure){
                      Navigator.pop(context);
                      showSnackBarWidget(context, state.error, Colors.red);
                    }
                  },
                  child:   CommonButtonWidget(size: size, buttonText: 'Sign in', onPressed: (){
                  if(formKey.currentState!.validate()){
                    showDialogSpinkitWidget(context, "Please Wait");
                    BlocProvider.of<UserAuthBloc>(context).add(LoginRequested(email: emailController.text.trim(), password: passwordController.text.trim()));
                  }
                }),
                  ),
                constantSizedBox(height: 10),
                TextButton(onPressed: (){}, child: const Text("Forgot the password?",style: TextStyle(color: Colors.black),)),
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?",style: TextStyle(color: Colors.grey),),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const RegisterScreen()));
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