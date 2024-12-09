import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoea/view/bottom_navigation/bottom_navigation_bar_widget.dart';
import 'package:http/http.dart' as http;

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  UserAuthBloc() : super(UserAuthInitial()) {
    on<SignUpRequested>((event, emit) async{
      emit(AuthLoading());
      try {
        await _auth.createUserWithEmailAndPassword(
          email: event.email, 
          password: event.password
          );
          emit(AuthSuccess("Signup Successful"));
      } on FirebaseAuthException catch (e){
        if(e.code == 'weak-password'){
          emit(AuthFailure("Password Strength is low"));
        } else if(e.code == 'email-already-in-use'){
          emit(AuthFailure("Email is already exist"));
        }
      }
      catch(e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LoginRequested>((event,emit) async{
      emit(AuthLoading());
      try{
        await _auth.signInWithEmailAndPassword(
          email: event.email, 
          password: event.password
          );
          emit(AuthSuccess("Login Successfull"));
      }
       catch(e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event,emit)async{
      emit(AuthLoading());
      try{
        await _auth.signOut();
        emit(AuthSuccess("Logout Successfull"));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SaveUserDetails>((event,emit) async{
      emit(AuthLoading());
      try{
        final userRef = FirebaseFirestore.instance.collection('users').doc(event.uid);
        await userRef.set({
          'email' : event.email,
          'first_name' : event.firstname,
          'last_name' : event.lastName,
          'phone_num' : event.mobileNum,
          'gender' : event.gender,
          'date_of_birth' : event.dateOfBirth,
          'uid' : event.uid,
          'imageUrl' : event.imageUrl,
          'user_type' : event.userType
        });
        emit(AuthSuccess("User data saved successfully"));
      } catch (e) {
        emit(AuthFailure("User details didnt submitted"));
      }
    });

    on<GoogleSignInRequested>((event,emit) async{
      emit(AuthLoading());
      try {
        final GoogleSignInAccount? googleuser = await _googleSignIn.signIn();

        if(googleuser == null){
          emit(AuthFailure("Google Sign-In cancelled"));
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleuser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
        );

        final userCredential = await _auth.signInWithCredential(credential);

        final user = userCredential.user;

        if(user != null){
          final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

          final userDoc = await userRef.get();

          if(!userDoc.exists){
            String? imageUrlBase64;
            if(user.photoURL != null){
              final response = await http.get(Uri.parse(user.photoURL!));

              if(response.statusCode == 200){
                imageUrlBase64 = base64Encode(response.bodyBytes);
              } else {
                imageUrlBase64 = '';
              }
            }
            await userRef.set({
              'uid' : user.uid,
              'email' :user.email,
              'first_name': user.displayName ?? '',
              'last_name' : '',
              'imageUrl' : imageUrlBase64 ?? '',
              'provider' : 'google',
              'phone_num' : ''
            });
          }
          emit(AuthSuccess("Google Sign-In Successfull"));
        } else  {
          emit(AuthFailure("Google Sign-In failed"));
        }

      } catch(e){
        emit(AuthFailure("Error: ${e.toString()}"));
      }
    });
  }
}
