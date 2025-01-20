import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/modules/home/presentation/widgets/product_bottom_sheet.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width / 10,
            height: MediaQuery.sizeOf(context).width / 10,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Color(0xffE4B002),
            ),
            child: const Center(
              child: Icon(
                CupertinoIcons.star_fill,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => ProductBottomSheet(product: product),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width / 4,
                  height: MediaQuery.sizeOf(context).width / 4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        product.image!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            ' ${product.name!}',
            style: normalStyle?.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              ' ${product.price} ج.م',
              style: labelStyle?.copyWith(color: myGreenColor, fontSize: 20),
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
