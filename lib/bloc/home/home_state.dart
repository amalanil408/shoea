part of 'home_bloc.dart';


abstract class HomeState {}

final class HomeInitial extends HomeState {}

class FetchUserDeatilsInHomeLoading extends HomeState{}

class FetchUserDeatilsInHomeLoaded extends HomeState {
  final String firstName;
  final String imageUrl;
  final String lastName;
  FetchUserDeatilsInHomeLoaded({required this.firstName, required this.imageUrl,required this.lastName});
}

class FetchUserDeatilsInHomeError extends HomeState {
  final String error;

  FetchUserDeatilsInHomeError({required this.error});

}