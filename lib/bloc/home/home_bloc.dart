import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchBrandDetails>((event, emit) async {
      try {
        emit(FetchBrandDetailsLoading());

        final fireStore = FirebaseFirestore.instance;
        QuerySnapshot brandDocs = await fireStore.collection('Brands').get();

        if (brandDocs.docs.isNotEmpty) {
          List<Map<String, String>> brands = brandDocs.docs.map((doc) {
            return {
              'name': doc['name'] as String,
              'icon': doc['icon'] as String,
            };
          }).toList();

          emit(FetchBrandDetailsLoaded(brands: brands));
        } else {
          emit(FetchBrandDetailsError(error: 'No brands found'));
        }
      } catch (e) {
        emit(FetchBrandDetailsError(error: e.toString()));
      }
    });

    on<FetchHomeData>((event, emit) async {
      try {
        emit(HomeLoading());
        final fireStore = FirebaseFirestore.instance;

        DocumentSnapshot userDoc =
            await fireStore.collection('users').doc(event.userId).get();
        if (!userDoc.exists) throw Exception("User not found");

        String firstName = userDoc['first_name'];
        String lastName = userDoc['last_name'];
        String base64Image = userDoc['imageUrl'];

        QuerySnapshot productDocs =
            await fireStore.collection('Products').get();
        List<Map<String, dynamic>> products = productDocs.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;

          List<Map<String, dynamic>> variants = [];
          if (data['variants'] != null && data['variants'] is List) {
            variants = (data['variants'] as List)
                .map((variant) => Map<String, dynamic>.from(variant))
                .toList();
          }

          var imageUrl = variants.isNotEmpty && variants[0]['images'] != null
              ? variants[0]['images'][0]
              : null;

          return {
            'product_name': data['product_name'] ?? '',
            'final_price': data['final_price'] ?? '',
            'product_id': data['product_id'] ?? '',
            'product_category': data['product_category'] ?? '',
            'base_price': data['base_price'] ?? '',
            'product_description': data['product_description'] ?? '',
            'product_brand': data['product_brand'] ?? '',
            'variants': variants,
            'image': imageUrl,
          };
        }).toList();

        DocumentSnapshot wishlistDoc =
            await fireStore.collection('Wishlist').doc(event.userId).get();
        List<dynamic> wishlist = wishlistDoc.exists
            ? (wishlistDoc.data() as Map<String, dynamic>)['products'] ?? []
            : [];

        emit(HomeLoaded(
          firstName: firstName,
          lastName: lastName,
          imageUrl: base64Image,
          products: products,
          wishlist: wishlist,
        ));
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });


    on<AddToWishlist>((event, emit) async {
      try {
        final firestore = FirebaseFirestore.instance;
        final wishlistDoc = firestore.collection('Wishlist').doc(event.userId);

        DocumentSnapshot docSnapshot = await wishlistDoc.get();
        List<dynamic> wishlist = docSnapshot.exists
            ? (docSnapshot.data() as Map<String, dynamic>)['products'] ?? []
            : [];

        if (wishlist.contains(event.productId)) {
          await wishlistDoc.update({
            'products': FieldValue.arrayRemove([event.productId]),
          });
        } else {
          await wishlistDoc.update({
            'products': FieldValue.arrayUnion([event.productId]),
          });
        }

        emit(HomeWishlistAdded());
        add(FetchHomeData(userId: event.userId));
      } catch (e) {
        emit(HomeError(error: "Failed to toggle wishlist: ${e.toString()}"));
      }
    });
  }
}
