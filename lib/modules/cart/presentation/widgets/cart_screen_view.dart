import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/core/widgets/customized_botton.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:maram/modules/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:maram/modules/cart/presentation/screens/checkout_screen.dart';

class CartScreenView extends StatefulWidget {
  const CartScreenView({
    required this.cartProducts,
    super.key,
  });
  final Map<ProductModel, List<int>> cartProducts;
  @override
  State<CartScreenView> createState() => _CartScreenViewState();
}

class _CartScreenViewState extends State<CartScreenView> {
  bool isLoading = false;
  double totalCost = 0;
  double deliveryCost = 25;
  @override
  void initState() {
    super.initState();
    totalCost = BlocProvider.of<CartCubit>(context).getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .37,
              child: ListView.builder(
                  itemCount: widget.cartProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.sizeOf(context).height / 6,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<CartCubit>(context)
                                      .removeProduct(
                                    widget.cartProducts.keys.toList()[index],
                                  );
                                  BlocProvider.of<CartCubit>(context)
                                      .getCartProducts();
                                  totalCost =
                                      BlocProvider.of<CartCubit>(context)
                                          .getTotalPrice();
                                },
                                icon: const Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'قطعة ',
                                    style: labelStyle?.copyWith(
                                        fontSize: 16,
                                        color: const Color(0xff9A9A9A)),
                                  ),
                                  Text(
                                    widget.cartProducts.values
                                        .elementAt(index)[0]
                                        .toString(),
                                    style: labelStyle?.copyWith(
                                        color: myGreenColor),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'باكيت ',
                                    style: labelStyle?.copyWith(
                                        fontSize: 16,
                                        color: const Color(0xff9A9A9A)),
                                  ),
                                  Text(
                                    widget.cartProducts.values
                                        .elementAt(index)[1]
                                        .toString(),
                                    style: labelStyle?.copyWith(
                                        color: myGreenColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                child: Text(
                                  widget.cartProducts.keys
                                          .toList()[index]
                                          .name ??
                                      'منتج',
                                  style: labelStyle?.copyWith(
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width / 3.3,
                                child: Text(
                                  widget.cartProducts.keys
                                          .toList()[index]
                                          .description ??
                                      'لا يوجد وصف',
                                  maxLines: 2,
                                  style: normalStyle?.copyWith(
                                    color: const Color(0xff9A9A9A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'الاجمالي/',
                                    style: normalStyle?.copyWith(
                                        color: const Color(0xff9A9A9A)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'ج.م',
                                        style: normalStyle?.copyWith(
                                            color: myGreenColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                9,
                                        child: Text(
                                          maxLines: 1,
                                          ((widget.cartProducts.values
                                                          .elementAt(index)[0] *
                                                      double.parse(widget
                                                          .cartProducts.keys
                                                          .toList()[index]
                                                          .price!)) +
                                                  (widget.cartProducts.values
                                                          .elementAt(index)[1] *
                                                      double.parse(widget
                                                          .cartProducts.keys
                                                          .toList()[index]
                                                          .packetPrice!)))
                                              .toString(),
                                          style: normalStyle?.copyWith(
                                              color: myGreenColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).height / 9.5,
                            height: MediaQuery.sizeOf(context).height / 9.5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.cartProducts.keys
                                            .toList()[index]
                                            .image ??
                                        'https://svgsilh.com/svg/40016.svg'))),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CustomTextFormField(
                      prefixIcon: const Icon(CupertinoIcons.tickets),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(myGreenColor),
                          ),
                          onPressed: () {},
                          child: Text(
                            'استخدام',
                            style: labelStyle?.copyWith(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      hintText: 'كود الخصم',
                      textInputType: TextInputType.text,
                      onSaved: (value) {},
                    ),
                  ),
                  Divider(color: Colors.grey.shade500, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'تفاصيل الطلب',
                        style: labelStyle?.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'ج.م ',
                            style: labelStyle?.copyWith(
                                fontSize: 20, color: myGreenColor),
                          ),
                          Text(
                            totalCost.toString(),
                            style: labelStyle?.copyWith(
                                fontSize: 20, color: myGreenColor),
                          ),
                        ],
                      ),
                      Text(
                        'سعر المنتجات',
                        style: labelStyle?.copyWith(
                            color: const Color(0xff9A9A9A)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'ج.م ',
                            style: labelStyle?.copyWith(
                                fontSize: 20, color: myGreenColor),
                          ),
                          Text(
                            deliveryCost.toString(),
                            style: labelStyle?.copyWith(
                                fontSize: 20, color: myGreenColor),
                          ),
                        ],
                      ),
                      Text(
                        'سعر التوصيل',
                        style: labelStyle?.copyWith(
                            color: const Color(0xff9A9A9A)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 9,
                        child:
                            Divider(color: Colors.grey.shade500, thickness: 2),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 9,
                        child:
                            Divider(color: Colors.grey.shade500, thickness: 2),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 9,
                        child:
                            Divider(color: Colors.grey.shade500, thickness: 2),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 9,
                        child:
                            Divider(color: Colors.grey.shade500, thickness: 2),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 9,
                        child:
                            Divider(color: Colors.grey.shade500, thickness: 2),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 9,
                        child:
                            Divider(color: Colors.grey.shade500, thickness: 2),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 9,
                        child:
                            Divider(color: Colors.grey.shade500, thickness: 2),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'ج.م ',
                            style: labelStyle?.copyWith(
                                fontSize: 20, color: myGreenColor),
                          ),
                          Text(
                            (totalCost + deliveryCost).toString(),
                            style: labelStyle?.copyWith(
                                fontSize: 20, color: myGreenColor),
                          ),
                        ],
                      ),
                      Text(
                        'المبلغ الاجمالي',
                        style: labelStyle?.copyWith(
                            fontSize: 20, color: myGreenColor),
                      ),
                    ],
                  ),
                  CustomizedButton(
                    isLoading: isLoading,
                    tittle: 'انتقل الى الدفع',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(
                              totalCost: totalCost,
                              deliveryCost: deliveryCost,
                              cartProducts: widget.cartProducts,
                            ),
                          ));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
