part of 'home_bloc.dart';


abstract class HomeEvent {}


class FetchUserDeatilsInHome extends HomeEvent {
  final String userId;

  FetchUserDeatilsInHome({required this.userId});

}