import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<FetchWishlist>(_onFetchWishlist);
    on<AddToWishlist>(_onAddToWishlist);
  }

  Future<void> _onFetchWishlist(
      FetchWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      final firestore = FirebaseFirestore.instance;
      final wishlistDoc =
          await firestore.collection('Wishlist').doc(event.userId).get();

      List<dynamic> wishlist = wishlistDoc.exists
          ? (wishlistDoc.data() as Map<String, dynamic>)['products'] ?? []
          : [];

      final products = await firestore.collection('Products').get();
      List<Map<String, dynamic>> wishlistProducts = products.docs
          .where((doc) => wishlist.contains(doc.id))
          .map((doc) => {
                'id': doc.id,
                ...doc.data(),
              })
          .toList();

      emit(WishlistLoaded(products: wishlistProducts));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }


   Future<void> _onAddToWishlist(
      AddToWishlist event, Emitter<WishlistState> emit) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final wishlistDoc = firestore.collection('Wishlist').doc(event.userId);

      DocumentSnapshot docSnapshot = await wishlistDoc.get();
      List<dynamic> wishlist = docSnapshot.exists
          ? (docSnapshot.data() as Map<String, dynamic>)['products'] ?? []
          : [];

      if (wishlist.contains(event.productId)) {
        // Remove product
        await wishlistDoc.update({
          'products': FieldValue.arrayRemove([event.productId]),
        });
      } else {
        // Add product
        await wishlistDoc.set({
          'products': FieldValue.arrayUnion([event.productId]),
        }, SetOptions(merge: true));
      }

      add(FetchWishlist(userId: event.userId));
    } catch (e) {
      emit(WishlistError(message: "Failed to toggle wishlist: ${e.toString()}"));
    }
  }
}
