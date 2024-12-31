part of 'account_bloc.dart';


abstract class AccountState {}

final class AccountInitial extends AccountState {}

class FetchUserDetailsInAccountLoading extends AccountState{}

class FetchUserDetailsInAccountLoaded extends AccountState {
  final String firstName;
  final String imageUrl;
  final String lastName;
  final String mobileNum;
  FetchUserDetailsInAccountLoaded({required this.firstName, required this.imageUrl,required this.lastName,required this.mobileNum});
}

class FetchUserDetailsInAccountError extends AccountState {
  final String error;

  FetchUserDetailsInAccountError({required this.error});

}


class FetchUserDetailsLoading extends AccountState {}

class FetchUserDetailsLoaded extends AccountState {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNum;
  final String gender;
  final String imageUrl;

  FetchUserDetailsLoaded({required this.firstName, required this.lastName, required this.email, required this.mobileNum, required this.gender, required this.imageUrl});
}

class FetchUserDetailsError extends AccountState {
  final String error;

  FetchUserDetailsError({required this.error});
}



class UpdateUserDetailsLoading extends AccountState {}

class UpdateUserDetailsLoaded extends AccountState {
  final String message;

  UpdateUserDetailsLoaded({required this.message});
}

class UpdateUserDetailsError extends AccountState {
  final String error;

  UpdateUserDetailsError({required this.error});
}



class AddAddressLoading extends AccountState {}

class AddAddressSuccess extends AccountState {}

class AddAddressFailure extends AccountState {
  final String error;

  AddAddressFailure({required this.error});
}


class AddressLoading extends AccountState {}

class AddressLoaded extends AccountState {
  final List<Map<String, dynamic>> addresses;

  AddressLoaded({required this.addresses});
}

class AddressError extends AccountState {
  final String error;

  AddressError({required this.error});
}