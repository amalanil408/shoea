import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/account/account_bloc.dart';
import 'package:shoea/view/account/address_screen.dart';

class AddAddressScreen extends StatefulWidget {
  final String userId; 

  const AddAddressScreen({super.key, required this.userId});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _addressController = TextEditingController();
  String _selectedCategory = 'Home'; 
  bool _isHomeSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
      ),
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AddAddressSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Address added successfully!"),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is AddAddressFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to add address: ${state.error}"),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                  hintText: "Enter your address",
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isHomeSelected,
                    onChanged: (value) {
                      setState(() {
                        _isHomeSelected = true;
                        _selectedCategory = "Home";
                      });
                    },
                  ),
                  const Text("Home"),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: !_isHomeSelected,
                    onChanged: (value) {
                      setState(() {
                        _isHomeSelected = false;
                        _selectedCategory = "Office";
                      });
                    },
                  ),
                  const Text("Office"),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final address = _addressController.text.trim();
                    if (address.isNotEmpty) {
                      context.read<AccountBloc>().add(
                            AddAddress(
                              userId: widget.userId,
                              address: address,
                              category: _selectedCategory,
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => const AddressScreen()), (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter an address"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, 
                    foregroundColor: Colors.white, 
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Save Address",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
