part of 'wishlist_bloc.dart';

abstract class WishlistEvent {}

class FetchWishlist extends WishlistEvent {
  final String userId;

  FetchWishlist({required this.userId});
}

class AddToWishlist extends WishlistEvent {
  final String userId;
  final String productId;

  AddToWishlist({required this.userId, required this.productId});
}