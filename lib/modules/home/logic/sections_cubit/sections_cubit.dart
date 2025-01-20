import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:maram/core/models/section_model.dart';
import 'package:maram/core/services/supabase_services.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'sections_state.dart';

class SectionsCubit extends Cubit<SectionsState> {
  SectionsCubit() : super(SectionsInitial());

  List<SectionModel> sections = [];
  void getSections(String categoryId) async {
    sections.clear();
    emit(SectionsLoading());
    try {
      var sectionsResponse = await SupabaseServices.fetchSections(categoryId);

      for (var i = 0; i < sectionsResponse.length; i++) {
        sections.add(SectionModel.fromList(sectionsResponse, i));
      }
      if (sections.isEmpty) {
        emit(SectionsEmpty());
      } else {
        emit(SectionsLoaded(sections));
      }
    } catch (e) {
      emit(SectionsError());
      log(e.toString());
    }
  }
}
