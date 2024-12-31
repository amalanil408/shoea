import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/account/account_bloc.dart';
import 'package:shoea/view/account/widgets/add_address_button.dart';
import 'package:shoea/view/account/widgets/address_listview_builder.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
      ),
      body: BlocProvider(
        create: (context) => AccountBloc()..add(FetchAddress(userId: userId!)),
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AddressLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddressLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: AddressListViewBuilder(addresses: state.addresses),
                  ),
                  const AddAddressButton(),
                ],
              );
            } else if (state is AddressError) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return const Center(child: Text("Start fetching addresses"));
          },
        ),
      ),
    );
  }
}
