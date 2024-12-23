import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/bloc/auth/user_auth_bloc.dart';

class LoginWithGoogleWidget extends StatelessWidget {
  const LoginWithGoogleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<UserAuthBloc>().add(GoogleSignInRequested());
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/search.png',height: 24,width: 24,),
            const SizedBox(width: 20,),
            Text('Continue with Google',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            )
          ],
        ),
      ),
    );
  }
}