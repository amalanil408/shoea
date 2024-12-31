part of 'home_bloc.dart';


abstract class HomeEvent {}


class FetchUserDeatilsInHome extends HomeEvent {
  final String userId;

  FetchUserDeatilsInHome({required this.userId});

}

class FetchBrandDetails extends HomeEvent {}


class FetchProducts extends HomeEvent {}


class FetchHomeData extends HomeEvent  {
  final String userId;

  FetchHomeData({required this.userId});
}

class AddToWishlist extends HomeEvent {
  final String userId;      
  final String productId;  

  AddToWishlist({required this.userId, required this.productId});
}


