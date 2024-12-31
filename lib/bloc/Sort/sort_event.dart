part of 'sort_bloc.dart';

abstract class SortEvent {}

class SortApplyEvent extends SortEvent {
  final double minPrice;
  final double maxPrice;
  final String category;
  final String brand;
  final int? sizeIndex;

  SortApplyEvent({
    required this.minPrice,
    required this.maxPrice,
    required this.category,
    required this.brand,
    this.sizeIndex,
  });
}


class FetchBrandSort extends SortEvent {}