import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/Search/search_bloc.dart';
import 'package:shoea/view/product/product_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CupertinoSearchTextField(
                placeholder: "Search for products",
                itemSize: 30,
                onChanged: (query) {
                  context.read<SearchBloc>().add(SearchProductEvent(query));
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoadedState) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ProductDetailScreen(product: product)));
                            },
                            title: Text(product['product_name']),
                            subtitle: Text(product['product_description']),
                          );
                        },
                      ),
                    );
                  } else if (state is SearchErrorState) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return const Center(child: Text('Search for a product'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
