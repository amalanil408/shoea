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

  }
}
