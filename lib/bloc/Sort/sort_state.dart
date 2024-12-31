part of 'sort_bloc.dart';

abstract class SortState {}

class SortInitialState extends SortState {}

class SortLoadingState extends SortState {}

class SortLoadedState extends SortState {
  final List<Map<String, dynamic>> products;

  SortLoadedState(this.products);
}

class SortErrorState extends SortState {
  final String message;

  SortErrorState(this.message);
}



class BrandLoadingSort extends SortState {}

class BrandLoadedSort extends SortState {
  final List<String> brands;

  BrandLoadedSort({required this.brands});
}

class BrandErrorSort extends SortState {
  final String message;

  BrandErrorSort({required this.message});
}