part of 'wishlist_bloc.dart';

abstract class WishlistState {}

final class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Map<String, dynamic>> products;

  WishlistLoaded({required this.products});
}

class WishlistError extends WishlistState {
  final String message;

  WishlistError({required this.message});
}