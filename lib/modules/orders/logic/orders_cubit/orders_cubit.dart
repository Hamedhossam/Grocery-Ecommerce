import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:maram/core/models/order_model.dart';
import 'package:maram/core/services/supabase_services.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  List<OrderModel> orders = [];

  void fetchOrders() async {
    emit(OrdersLoading());
    try {
      var response = await SupabaseServices.fetchOrders();
      orders = response
          .map((e) => OrderModel.fromJson(e))
          .toList()
          .reversed
          .toList();
      if (orders.isEmpty) {
        emit(OrdersEmpty());
      } else {
        emit(OrdersLoaded(orders: orders));
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void removeOrder(OrderModel order) {
    orders.remove(order);
    emit(OrdersLoaded(orders: orders));
  }

  void clearOrders() {
    orders.clear();
    emit(OrdersEmpty());
  }

  void getOrders() {
    emit(OrdersLoading());
    if (orders.isEmpty) {
      emit(OrdersEmpty());
    } else {
      emit(OrdersLoaded(orders: orders));
    }
  }
}
