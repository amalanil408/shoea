part of 'account_bloc.dart';

abstract class AccountEvent {}

class FetchUserDetailsInAccount extends AccountEvent{
  final String userId;

  FetchUserDetailsInAccount({required this.userId});
}

class FetchUserDetails extends AccountEvent{
  final String userId;

  FetchUserDetails({required this.userId});
}

class UpdateUserDetails extends AccountEvent {
  final String userId;
  final String firstName;
  final String lastName;
  final String gender;
  final String mobileNum;

  UpdateUserDetails({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.mobileNum,
  });
}
