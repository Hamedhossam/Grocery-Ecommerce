import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/core/services/supabase_services.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitial());

  void buyProducts(Map<ProductModel, List<int>> cartProducts) {
    emit(CheckOutLoading());
    try {
      SupabaseServices.buyProducts(cartProducts);
      emit(CheckOutSuccess());
    } on Exception catch (e) {
      emit(CheckOutError());
      log(e.toString());
    }
  }
}
