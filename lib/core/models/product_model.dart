class ProductModel {
  String? id;
  String? name;
  String? description;
  String? details;
  String? image;
  String? price;
  String? packetPrice;
  String? category;
  String? quantity;
  String? packetQuantity;
  String? section;
  bool? packetOnly;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.details,
    required this.image,
    required this.price,
    required this.category,
    required this.quantity,
    required this.section,
    required this.packetPrice,
    required this.packetQuantity,
    required this.packetOnly,
  });
  factory ProductModel.fromBestsellers(List<dynamic> list, int index) {
    return ProductModel(
      id: list[index]['products']['id'] ?? '',
      name: list[index]['products']['name'],
      description: list[index]['products']['description'],
      details: list[index]['products']['details'],
      image: list[index]['products']['image'].toString(),
      price: list[index]['products']['price'].toString(),
      category: list[index]['products']['category_id'].toString(),
      quantity: list[index]['products']['quantity'].toString(),
      section: list[index]['products']['section_id'].toString(),
      packetPrice: list[index]['products']['packet_price'].toString(),
      packetQuantity: list[index]['products']['packet_quantity'],
      packetOnly: list[index]['products']['packet_only'],
    );
  }
  factory ProductModel.fromSections(List<dynamic> list, int index) {
    return ProductModel(
      id: list[index]['id'] ?? '',
      name: list[index]['name'],
      description: list[index]['description'],
      details: list[index]['details'],
      image: list[index]['image'].toString(),
      price: list[index]['price'].toString(),
      category: list[index]['category_id'].toString(),
      quantity: list[index]['quantity'].toString(),
      section: list[index]['section_id'].toString(),
      packetPrice: list[index]['packet_price'].toString(),
      packetQuantity: list[index]['packet_quantity'],
      packetOnly: list[index]['packet_only'],
    );
  }
}
