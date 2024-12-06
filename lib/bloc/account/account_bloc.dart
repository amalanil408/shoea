import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<FetchUserDetailsInAccount>((event, emit) async{
      try {
        final fireStore = FirebaseFirestore.instance;
        DocumentSnapshot userDoc = await fireStore.collection('users').doc(event.userId).get();

        if(userDoc.exists){
          String firstName = userDoc['first_name'];
          String base64Image = userDoc['imageUrl'];
          String lastName = userDoc['last_name'];
          String mobileNum = userDoc['phone_num'];

          emit(FetchUserDetailsInAccountLoaded(firstName: firstName, imageUrl: base64Image, lastName: lastName, mobileNum: mobileNum));
        } else {
          emit(FetchUserDetailsInAccountError(error: "Error While Loading"));
        }
      } catch (e) {
        emit(FetchUserDetailsInAccountError(error: e.toString()));
      }
    });
  }
}
