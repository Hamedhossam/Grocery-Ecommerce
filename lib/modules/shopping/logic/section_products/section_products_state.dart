part of 'section_products_cubit.dart';

@immutable
sealed class SectionProductsState {}

final class SectionProductsInitial extends SectionProductsState {}

final class SectionProductsLoaded extends SectionProductsState {
  final List<ProductModel> products;
  SectionProductsLoaded(this.products);
}

final class SectionProductsError extends SectionProductsState {}

final class SectionProductsLoading extends SectionProductsState {}

final class SectionProductsEmpty extends SectionProductsState {}
