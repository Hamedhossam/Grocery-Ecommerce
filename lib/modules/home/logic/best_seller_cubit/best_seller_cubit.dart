import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/core/services/supabase_services.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'best_seller_state.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  BestSellerCubit() : super(BestSellerInitial());
  List<ProductModel> bestSellerProducts = [];
  void getBestSeller() async {
    emit(BestSellerLoading());
    try {
      var response = await SupabaseServices.fetchBestsellers();
      for (var i = 0; i < response.length; i++) {
        if (int.parse(response[i]['products']['quantity']) <= 0) {
          continue;
        } else {
          bestSellerProducts.add(ProductModel.fromBestsellers(response, i));
        }
      }
      if (bestSellerProducts.isEmpty) {
        emit(BestSellerEmpty());
      } else {
        emit(BestSellerSuccess(bestSellerProducts));
      }
    } on Exception catch (e) {
      emit(BestSellerError());
      log(e.toString());
    }
  }
}
