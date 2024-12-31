part of 'user_auth_bloc.dart';

abstract class UserAuthEvent {}

class SignUpRequested extends UserAuthEvent{
  final String email;
  final String password;

  SignUpRequested({required this.email, required this.password});
  
}

class LoginRequested extends UserAuthEvent{
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

}

class SaveUserDetails extends UserAuthEvent{
  final String uid;
  final String email;
  final String firstname;
  final String lastName;
  final String mobileNum;
  final String gender;
  final String dateOfBirth;
  final String? imageUrl;
  final String userType;
  final List<dynamic> address;
  SaveUserDetails({required this.uid, required this.email, required this.firstname, required this.lastName, required this.mobileNum, required this.gender, required this.dateOfBirth , this.imageUrl,required this.userType,required this.address});
}

class LogoutRequested extends UserAuthEvent{}

class GoogleSignInRequested extends UserAuthEvent{}