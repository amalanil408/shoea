import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/bloc/auth/user_auth_bloc.dart';
import 'package:shoea/util/common_button_widget.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/view/auth/login_screen.dart';
import 'package:shoea/view/auth/register_screen.dart';
import 'package:shoea/view/auth/widget/divider_widget.dart';
import 'package:shoea/view/auth/widget/login_with_google_widget.dart';
import 'package:shoea/view/auth/widget/login_with_mobile_widget.dart';

class AuthSelectScreen extends StatelessWidget {
  const AuthSelectScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size =MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: scaffoldBackGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Image.asset('assets/img/auth_select.jpg'),
          Text("Let's you in",
          style: GoogleFonts.roboto(
            fontSize: 38,
            fontWeight: FontWeight.bold
          )
          ),
          constantSizedBox(height: 40),
          const LoginWithGoogleWidget(),
          const LoginWithMobileWidget(),
          constantSizedBox(height: 20),
          const DividerWidget(),
          constantSizedBox(height: 20),
          CommonButtonWidget(size: size, buttonText: 'Sign in with password', onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
          }),
          constantSizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?",style: TextStyle(color: Colors.grey),),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(value: BlocProvider.of<UserAuthBloc>(context),child: RegisterScreen(),)));
              }, child: const Text("Sign up",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
            ],
          ),
        ],
      ),
    );
  }
}


