part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;

  OrdersLoaded({required this.orders});
}

final class OrdersError extends OrdersState {}

final class OrdersEmpty extends OrdersState {}
