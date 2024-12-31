import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) async {
      try {
        final fireStore = FirebaseFirestore.instance;
        final cartDoc = fireStore.collection('Cart').doc(event.userId);

        await cartDoc.set({
          'products': FieldValue.arrayUnion([event.productId]),
        }, SetOptions(merge: true));
        emit(AddToCartSuccess());
      } catch (e) {
        emit(AddToCartError(error: e.toString()));
      }
    });

    on<FetchCart>((event, emit) async {
      emit(CartLoading());
      try {
        final fireStore = FirebaseFirestore.instance;

        final cartDoc =
            await fireStore.collection('Cart').doc(event.userId).get();

        if (cartDoc.exists) {
          final cartData = cartDoc.data() ?? {};
          final productIds = List<String>.from(cartData['products'] ?? []);

          final List<Map<String, dynamic>> products = [];
          for (var productId in productIds) {
            final productDoc =
                await fireStore.collection('Products').doc(productId).get();
            if (productDoc.exists) {
              products.add(productDoc.data()!);
            }
          }

          emit(CartLoaded(products: products));
        } else {
          emit(CartLoaded(products: []));
        }
      } catch (e) {
        emit(CartError(error: e.toString()));
      }
    });

    on<DeleteFromCart>((event, emit) async {
      try {
        final fireStore = FirebaseFirestore.instance;
        final cartDoc = fireStore.collection('Cart').doc(event.userId);
        await cartDoc.update({
          'products': FieldValue.arrayRemove([event.productId]),
        });
      } catch (e) {
        emit(CartError(error: e.toString()));
      }
    });


     on<CheckIfInWishlist>((event, emit) async {
      try {
        emit(WishlistLoading());
        final doc = await FirebaseFirestore.instance
            .collection('Wishlist')
            .doc(event.userId)
            .get();

        final products = List<String>.from(doc.data()?['products'] ?? []);
        final isInWishlist = products.contains(event.productId);

        emit(WishlistStatus(isInWishlist: isInWishlist));
      } catch (e) {
        emit(WishlistError(error: e.toString()));
      }
    });



    on<AddToWishlist>((event, emit) async {
      try {
        await FirebaseFirestore.instance
            .collection('Wishlist')
            .doc(event.userId)
            .set({
          'products': FieldValue.arrayUnion([event.productId]),
        }, SetOptions(merge: true));
        emit(WishlistUpdated());
      } catch (e) {
        emit(WishlistError(error: e.toString()));
      }
    });


     on<RemoveFromWishlist>((event, emit) async {
      try {
        await FirebaseFirestore.instance
            .collection('Wishlist')
            .doc(event.userId)
            .update({
          'products': FieldValue.arrayRemove([event.productId]),
        });
        emit(WishlistUpdated());
      } catch (e) {
        emit(WishlistError(error: e.toString()));
      }
    });

  }
}
