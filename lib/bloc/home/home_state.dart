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


class FetchBrandDetailsLoading extends HomeState {}


class FetchBrandDetailsLoaded extends HomeState {
  final List<Map<String , dynamic>> brands;

  FetchBrandDetailsLoaded({required this.brands});

}

class FetchBrandDetailsError extends HomeState {
  final String error;

  FetchBrandDetailsError({required this.error});
}



class FetchProductsLoading extends HomeState {}

class FetchProductsLoaded extends HomeState {
  final List<Map<String , dynamic>> products;

  FetchProductsLoaded({required this.products});

}

class FetchProductsError extends HomeState {
  final String error;

  FetchProductsError({required this.error});
}



class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String firstName;
  final String lastName;
  final String imageUrl;
  final List<Map<String,dynamic>> products;
  final List<dynamic> wishlist;

  HomeLoaded({required this.firstName, required this.lastName, required this.imageUrl, required this.products,required this.wishlist});
}

class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});
}




class HomeWishlistAdded extends HomeState {}
