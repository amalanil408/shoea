import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

    on<SearchProductEvent>((event, emit) async {
      emit(SearchLoadingState());

      try {
        final query = event.query.toLowerCase();
        final snapShot = await _firebaseFirestore.collection('Products').get();
        final products = snapShot.docs
            .map((doc) => doc.data())
            .where((product) {
              final productName = (product['product_name'] as String?)?.toLowerCase() ?? '';
              return productName.contains(query);
            })
            .toList();

        emit(SearchLoadedState(products));
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });
  }
}
