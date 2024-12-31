import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/Sort/sort_bloc.dart';

class SortScreen extends StatefulWidget {
  const SortScreen({super.key});

  @override
  State<SortScreen> createState() => _SortScreenState();
}

class _SortScreenState extends State<SortScreen> {
  double _minPrice = 0;
  double _maxPrice = 10000;
  RangeValues _priceRange = const RangeValues(0, 1000);
  String _selectedCategory = 'common';
  String _selectedBrand = 'Select Brand';
  int? _selectedSize;

  final List<String> _categories = ['common', 'men', 'women'];
  final List<int> _sizes = List.generate(9, (index) => index + 6); 

  @override
  void initState() {
    super.initState();
    context.read<SortBloc>().add(FetchBrandSort());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Price Range',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 10000,
              divisions: 10,
              labels: RangeLabels(
                '\$${_priceRange.start.toStringAsFixed(0)}',
                '\$${_priceRange.end.toStringAsFixed(0)}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                  _minPrice = values.start;
                  _maxPrice = values.end;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Sizes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _sizes.length,
                itemBuilder: (context, index) {
                  final size = _sizes[index];
                  final isSelected = _selectedSize == size;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSize = size;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: CircleAvatar(
                        backgroundColor:
                            isSelected ? Colors.black : Colors.grey[200],
                        child: Text(
                          size.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text('Brands',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            BlocBuilder<SortBloc, SortState>(
              builder: (context, state) {
                if (state is BrandLoadingSort) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BrandLoadedSort) {
                  final brands = ['Select Brand', ...state.brands];
                  return Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<String>(
                        value: _selectedBrand,
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            _selectedBrand = value!;
                          });
                        },
                        items: brands.map((brand) {
                          return DropdownMenuItem<String>(
                            value: brand,
                            child: Text(brand),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                } else if (state is BrandErrorSort) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return Container();
              },
            ),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _priceRange = const RangeValues(0, 1000);
                      _selectedCategory = 'common';
                      _selectedBrand = 'Select Brand';
                      _selectedSize = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Clear', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  
                  onPressed: () {
                    context.read<SortBloc>().add(SortApplyEvent(
                          minPrice: _minPrice,
                          maxPrice: _maxPrice,
                          category: _selectedCategory,
                          brand: _selectedBrand,
                          sizeIndex: _selectedSize,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Apply', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
