part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<Map<String, dynamic>> products;

  SearchLoadedState(this.products);
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState(this.error);
}