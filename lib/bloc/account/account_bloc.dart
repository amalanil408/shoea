import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<FetchUserDetailsInAccount>((event, emit) async{
      try {
        final fireStore = FirebaseFirestore.instance;
        DocumentSnapshot userDoc = await fireStore.collection('users').doc(event.userId).get();

        if(userDoc.exists){
          String firstName = userDoc['first_name'];
          String base64Image = userDoc['imageUrl'];
          String lastName = userDoc['last_name'];
          String mobileNum = userDoc['phone_num'];

          emit(FetchUserDetailsInAccountLoaded(firstName: firstName, imageUrl: base64Image, lastName: lastName, mobileNum: mobileNum));
        } else {
          emit(FetchUserDetailsInAccountError(error: "Error While Loading"));
        }
      } catch (e) {
        emit(FetchUserDetailsInAccountError(error: e.toString()));
      }
    });


    on<FetchUserDetails>((event,emit) async{
      try{
        final fireStore = FirebaseFirestore.instance;
        DocumentSnapshot userDoc = await fireStore.collection('users').doc(event.userId).get();

        if(userDoc.exists){
          String firstName = userDoc['first_name'];
          String lastName = userDoc['last_name'];
          String email = userDoc['email'];
          String mobileNum = userDoc['phone_num'];
          String gender = userDoc['gender'];
          String imageUrl = userDoc['imageUrl'];

          emit(FetchUserDetailsLoaded(firstName: firstName, lastName: lastName, email: email, mobileNum: mobileNum, gender: gender, imageUrl: imageUrl));
        } else {
          emit(FetchUserDetailsError(error: "Error While Loading"));
        }
      } catch (e) {
        emit(FetchUserDetailsError(error: e.toString()));
      }
    });


    on<UpdateUserDetails>((event,emit) async{
      try {
        await FirebaseFirestore.instance.collection('users').doc(event.userId).update({
          'first_name' : event.firstName,
          'last_name': event.lastName,
          'gender' : event.gender,
          'phone_num' : event.mobileNum
        });
        emit(UpdateUserDetailsLoaded(message: 'profile Update Successfully'));
      } catch (e) {
        emit(UpdateUserDetailsError(error: e.toString()));
      }
    });


    on<AddAddress>((event,emit) async{
      try {
        final fireStore = FirebaseFirestore.instance;
        emit(AddAddressLoading());

        final userDocRef = fireStore.collection('users').doc(event.userId);
        await userDocRef.update({
          'address' : FieldValue.arrayUnion([
            {'address' : event.address, 'category' : event.category}
          ])
        });
        emit(AddAddressSuccess());
      } catch (e) {
        emit(AddAddressFailure(error: e.toString()));
      }
    });


    on<FetchAddress>((event,emit) async{
      emit(AddressLoading());
      try {
        final fireStore = FirebaseFirestore.instance;
        final userRefDoc = fireStore.collection('users').doc(event.userId);
        final userDoc = await userRefDoc.get();

        if(userDoc.exists){
          final address = List<Map<String,dynamic>>.from(userDoc.data()?['address'] ?? []);
          emit(AddressLoaded(addresses: address));
        } else {
          emit(AddressError(error: "User Not Found"));
        }
      } catch (e) {
        emit(AddressError(error: e.toString()));
      }
    });
  }
}
