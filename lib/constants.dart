import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// import 'package:maram/core/models/category_model.dart';
// import 'package:maram/core/models/product_model.dart';

// ProductModel productModel = ProductModel(
//   id: "1",
//   name: 'شيبسي تايجر اكسيلانس ',
//   description: ' شيبسي تايجر اكسيلانس بطعم الليمون الحلو',
//   details: '  شيبسي تايجر اكسيلانس بطعم الليمون الحلو - 100جم - 1 قطعة',
//   image: 'assets/images/product_test.jpeg',
//   price: '15.00',
//   category: 'المواد الغذائية',
//   section: 'شيبسي',
//   quantity: '12',
//   packetPrice: '50.00',
//   packetQuantity: '8',
//   packetOnly: false,
// );
// ProductModel productModel2 = ProductModel(
//   id: "2",
//   name: 'هوهوز كيك شوكولاتة',
//   description: 'كيك شوكولاتة كريمة وكاكاو ميني هوهوز - 24جم - 1 قطعة',
//   details: 'كيك شوكولاتة كريمة وكاكاو ميني هوهوز - 24جم - 1 قطعة',
//   image: 'assets/images/product2_test.png',
//   price: '10.00',
//   category: 'المواد الغذائية',
//   section: 'كيك',
//   quantity: '16',
//   packetPrice: '50.00',
//   packetQuantity: '8',
//   packetOnly: false,
// );
// CategoryModel categoryModel1 = CategoryModel(
//   id: "1",
//   name: 'المواد الغذائية',
//   image: 'assets/icons/category1.png',
// );
// CategoryModel categoryModel2 = CategoryModel(
//   id: "2",
//   name: 'المشروبات',
//   image: 'assets/icons/category2.png',
// );
// CategoryModel categoryModel3 = CategoryModel(
//   id: "3",
//   name: 'الزيوت',
//   image: 'assets/icons/category3.png',
// );
// CategoryModel categoryModel4 = CategoryModel(
//   id: "4",
//   name: 'المنظفات',
//   image: 'assets/icons/category4.png',
// );
// CategoryModel categoryModel5 = CategoryModel(
//   id: "5",
//   name: 'المكعرونة',
//   image: 'assets/icons/category5.png',
// );

const Color myGreenColor = Color(0xff219c73);
TextStyle? labelStyle = const TextStyle(
  fontFamily: "NotoKufiArabic",
  fontSize: 18,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
TextStyle? specialStyle = const TextStyle(
  fontFamily: "NotoKufiArabic",
  fontSize: 20,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
TextStyle? lightStyle = const TextStyle(
  fontFamily: "NotoKufiArabic",
  fontSize: 16,
  color: Color.fromARGB(142, 83, 82, 82),
  fontWeight: FontWeight.bold,
);
TextStyle? normalStyle = const TextStyle(
  fontFamily: "NotoKufiArabic",
  fontSize: 17,
  color: Colors.black,
);
String generateRandom6DigitNumber() {
  final random = Random();
  String number = '';

  for (int i = 0; i < 6; i++) {
    number += random.nextInt(10).toString();
  }

  return number;
}

String getFormattedDateTime() {
  final now = DateTime.now();
  final formatter = DateFormat('dd-MM-yyyy hh:mm a');
  return formatter.format(now);
}
