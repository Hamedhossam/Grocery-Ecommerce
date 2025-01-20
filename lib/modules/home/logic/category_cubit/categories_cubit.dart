import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:maram/core/models/category_model.dart';
import 'package:maram/core/models/section_model.dart';
import 'package:maram/core/services/supabase_services.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  List<CategoryModel> categories = [];
  List<SectionModel> sections = [];
  void getCategories() async {
    categories.clear();
    emit(CategoriesLoading());
    try {
      var categoriesResponse = await SupabaseServices.fetchCategories();
      for (var i = 0; i < categoriesResponse.length; i++) {
        categories.add(CategoryModel.fromList(categoriesResponse, i));
      }
      emit(CategoriesSuccess(categories));
    } on Exception catch (e) {
      emit(CategoriesError());
      log(e.toString());
    }
  }
}
