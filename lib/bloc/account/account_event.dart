part of 'account_bloc.dart';

abstract class AccountEvent {}

class FetchUserDetailsInAccount extends AccountEvent{
  final String userId;

  FetchUserDetailsInAccount({required this.userId});
}