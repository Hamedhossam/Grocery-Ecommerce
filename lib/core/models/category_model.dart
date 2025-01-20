class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });
  factory CategoryModel.fromList(List<dynamic> list, int categoryIndex) {
    return CategoryModel(
      id: list[categoryIndex]['id'],
      name: list[categoryIndex]['name'],
      image: list[categoryIndex]['image'],
    );
  }
}
