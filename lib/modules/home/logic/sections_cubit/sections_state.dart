part of 'sections_cubit.dart';

@immutable
sealed class SectionsState {}

final class SectionsInitial extends SectionsState {}

final class SectionsLoaded extends SectionsState {
  final List<SectionModel> sectionsList;
  SectionsLoaded(this.sectionsList);
}

final class SectionsError extends SectionsState {}

final class SectionsLoading extends SectionsState {}

final class SectionsEmpty extends SectionsState {}
