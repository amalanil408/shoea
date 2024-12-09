import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/home/home_bloc.dart';

class ProductBrandCircleAvatar extends StatelessWidget {
  const ProductBrandCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchBrandDetails()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is FetchBrandDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchBrandDetailsLoaded) {
            int avatarCount = state.brands.length > 8 ? 8 : state.brands.length;
            List<Widget> avatars = List.generate(avatarCount, (index) {
              final brand = state.brands[index];

              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        ClipOval(
                          child: Image.memory(
                            base64Decode(brand['icon']!),
                            width: 40,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      brand['name']!,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            });

            return Column(
              children: List.generate(
                (avatarCount / 4).ceil(),
                (rowIndex) {
                  int startIndex = rowIndex * 4;
                  int endIndex = startIndex + 4;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: avatars.sublist(
                          startIndex, endIndex > avatarCount ? avatarCount : endIndex),
                    ),
                  );
                },
              ),
            );
          } else if (state is FetchBrandDetailsError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No brands available'));
        },
      ),
    );
  }
}
