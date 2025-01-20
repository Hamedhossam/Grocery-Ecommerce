class OrderModel {
  final String userId;
  final String createdAt;
  final String paymentMethod;
  final String orderCode;
  String deliveryAddress;
  String status;
  String paymentStatus;
  String deliveryMethod;
  String total;
  String note;
  List<String> productsImages;

  OrderModel({
    required this.userId,
    required this.createdAt,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryMethod,
    required this.total,
    required this.note,
    required this.productsImages,
    required this.orderCode,
    required this.deliveryAddress,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userId: json['user_id'],
      createdAt: json['created_at'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      deliveryMethod: json['delivery_method'],
      total: json['total'].toString(),
      note: json['note'],
      productsImages: json['product_images'].cast<String>(),
      orderCode: json['order_code'],
      deliveryAddress: json['delivery_address'],
    );
  }
}
