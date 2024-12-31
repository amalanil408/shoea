part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchProductEvent extends SearchEvent {
  final String query;

  SearchProductEvent(this.query);
}