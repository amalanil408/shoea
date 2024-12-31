part of 'cart_bloc.dart';


abstract class CartState {}

final class CartInitial extends CartState {}

class AddToCartSuccess extends CartState{}

class AddToCartError extends CartState{
  final String error;

  AddToCartError({required this.error});

}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<dynamic> products;

  CartLoaded({required this.products});
}

class CartError extends CartState {
  final String error;

  CartError({required this.error});
}


class WishlistLoading extends CartState {}

class WishlistStatus extends CartState {
  final bool isInWishlist;

  WishlistStatus({required this.isInWishlist});
}

class WishlistUpdated extends CartState {}

class WishlistError extends CartState {
  final String error;

  WishlistError({required this.error});
}