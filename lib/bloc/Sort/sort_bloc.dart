import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'sort_event.dart';
part 'sort_state.dart';

class SortBloc extends Bloc<SortEvent, SortState> {
  SortBloc() : super(SortInitialState()) {
    // Register the handler for SortApplyEvent
    on<SortApplyEvent>(_onSortApplyEvent);

    on<FetchBrandSort>((event,emit)async{
      final fireStore = FirebaseFirestore.instance;
      try {
        emit(BrandLoadingSort());

        final brandsSnapshot = await fireStore.collection('Brands').get();
        final brands = brandsSnapshot.docs.map((doc) => doc['name'] as String).toList();
        emit(BrandLoadedSort(brands: brands));
      } catch(e) {
        emit(BrandErrorSort(message: e.toString()));
      }
    });
  }

  Future<void> _onSortApplyEvent(SortApplyEvent event, Emitter<SortState> emit) async {
    emit(SortLoadingState());

    try {
      var query = FirebaseFirestore.instance.collection('products')
          .where('product_brand', isEqualTo: event.brand)
          .where('product_category', isEqualTo: event.category)
          .where('final_price', isGreaterThanOrEqualTo: event.minPrice)
          .where('final_price', isLessThanOrEqualTo: event.maxPrice);

      if (event.sizeIndex != null) {
        query = query.where('size', isEqualTo: event.sizeIndex);
      }

      var snapshot = await query.get();
      var products = snapshot.docs.map((doc) => doc.data()).toList();

      emit(SortLoadedState(products));
    } catch (e) {
      emit(SortErrorState('Failed to load products: $e'));
    }
  }
}
