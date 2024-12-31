part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final String userId;      
  final String productId;

  AddToCart({required this.userId, required this.productId}); 
}


class FetchCart extends CartEvent {
  final String userId;

  FetchCart({required this.userId});
}

class DeleteFromCart extends CartEvent {
  final String userId;
  final String productId;

  DeleteFromCart({required this.userId, required this.productId});
}



class CheckIfInWishlist extends CartEvent {
  final String userId;
  final String productId;

  CheckIfInWishlist({required this.userId, required this.productId});
}

class AddToWishlist extends CartEvent {
  final String userId;
  final String productId;

  AddToWishlist({required this.userId, required this.productId});
}

class RemoveFromWishlist extends CartEvent {
  final String userId;
  final String productId;

  RemoveFromWishlist({required this.userId, required this.productId});
}