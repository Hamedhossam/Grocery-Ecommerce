part of 'check_out_cubit.dart';

@immutable
sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}

final class CheckOutSuccess extends CheckOutState {}

final class CheckOutError extends CheckOutState {}

final class CheckOutLoading extends CheckOutState {}
