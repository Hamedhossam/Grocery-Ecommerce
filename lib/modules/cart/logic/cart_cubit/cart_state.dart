part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  final Map<ProductModel, List<int>> cartProducts;
  CartLoaded({required this.cartProducts});
}

final class CartLoading extends CartState {}

final class CartEmpty extends CartState {}

final class CartError extends CartState {}
