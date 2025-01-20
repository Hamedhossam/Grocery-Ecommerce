part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesError extends CategoriesState {}

final class CategoriesEmpty extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;
  CategoriesSuccess(this.categories);
}
