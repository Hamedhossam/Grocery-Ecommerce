class BestSellerModel {
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

  BestSellerModel({
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
}
