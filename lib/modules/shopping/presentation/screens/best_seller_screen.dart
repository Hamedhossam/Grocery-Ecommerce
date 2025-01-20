import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:maram/modules/home/presentation/widgets/product_widget.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key, required this.products});
  static const routeName = 'bestSellerScreen';
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'الاكثر مبيعاً',
          style: specialStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CustomTextFormField(
              hintText: 'قم بالبحث عن المنتجات ',
              textInputType: TextInputType.text,
              suffixIcon:
                  const Icon(Icons.search, size: 30, color: myGreenColor),
              onSaved: (value) {},
            ),
          ),
          Expanded(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 3.5,
              ),
              itemBuilder: (context, index) =>
                  ProductWidget(product: products[index]),
              itemCount: products.length,
            ),
          ))
        ]),
      ),
    );
  }
}
