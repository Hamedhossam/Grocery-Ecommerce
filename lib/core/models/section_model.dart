class SectionModel {
  final String id;
  final String title;
  List<Map<String, dynamic>> products = [];

  SectionModel({
    required this.title,
    required this.id,
    required this.products,
  });
  factory SectionModel.fromList(List<Map<String, dynamic>> response, int i) {
    return SectionModel(
      id: response[i]['id'],
      title: response[i]['title'],
      products: response[i]['products'],
    );
  }
}
