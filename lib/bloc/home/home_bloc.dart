import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchUserDeatilsInHome>((event,emit) async{
      try {
      final fireStore = FirebaseFirestore.instance;
        DocumentSnapshot userDoc = await fireStore.collection('users').doc(event.userId).get();

        if(userDoc.exists){
          String firstName = userDoc['first_name'];
          String base64Image = userDoc['imageUrl'];
          String lastName = userDoc['last_name'];

          emit(FetchUserDeatilsInHomeLoaded(firstName: firstName, imageUrl: base64Image,lastName:lastName ));
        } else {
          emit(FetchUserDeatilsInHomeError(error: 'Not found'));
        }
      } catch (e) {
        emit(FetchUserDeatilsInHomeError(error: e.toString()));
      }
    });

    on<FetchBrandDetails>((event, emit) async {
  try {
    emit(FetchBrandDetailsLoading());  // Emit loading state

    final fireStore = FirebaseFirestore.instance;
    QuerySnapshot brandDocs = await fireStore.collection('brands').get();

    print('Fetched brands count: ${brandDocs.docs.length}');  // Log number of docs fetched

    if (brandDocs.docs.isNotEmpty) {
      List<Map<String, String>> brands = brandDocs.docs.map((doc) {
        print('Brand data: ${doc.data()}');  // Log each brand's data
        return {
          'name': doc['name'] as String,
          'icon': doc['icon'] as String,
        };
      }).toList();

      emit(FetchBrandDetailsLoaded(brands: brands));  // Emit loaded state
    } else {
      emit(FetchBrandDetailsError(error: 'No brands found'));
    }
  } catch (e) {
    emit(FetchBrandDetailsError(error: e.toString()));  // Emit error state
  }
});


  }
}
