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