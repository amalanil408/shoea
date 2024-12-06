part of 'user_auth_bloc.dart';

abstract class UserAuthState {}

final class UserAuthInitial extends UserAuthState {}

class AuthLoading extends UserAuthState{}

class AuthSuccess extends UserAuthState{
  final String message;
  AuthSuccess(this.message);
}

class AuthFailure extends UserAuthState{
  final String error;
  AuthFailure(this.error);
}
