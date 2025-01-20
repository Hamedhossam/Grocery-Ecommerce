import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/core/services/supabase_services.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'section_products_state.dart';

class SectionProductsCubit extends Cubit<SectionProductsState> {
  SectionProductsCubit() : super(SectionProductsInitial());

  List<ProductModel> products = [];
  void getProducts(String sectionId) async {
    emit(SectionProductsLoading());
    try {
      var productsResponse = await SupabaseServices.fetchProducts(sectionId);
      for (var i = 0; i < productsResponse.length; i++) {
        if (int.parse(productsResponse[i]['quantity']) <= 0) {
          continue;
        } else {
          products.add(ProductModel.fromSections(productsResponse, i));
        }
      }
      if (products.isEmpty) {
        emit(SectionProductsEmpty());
      } else {
        emit(SectionProductsLoaded(products));
      }
    } on Exception catch (e) {
      emit(SectionProductsError());
      log(e.toString());
    }
  }
}
