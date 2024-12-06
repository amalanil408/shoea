import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
          'imageUrl' : event.imageUrl
        });
        emit(AuthSuccess("User data saved successfully"));
      } catch (e) {
        emit(AuthFailure("User details didnt submitted"));
      }
    });
  }
}
