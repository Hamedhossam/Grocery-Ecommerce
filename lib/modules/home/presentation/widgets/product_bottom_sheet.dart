import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/core/widgets/customized_botton.dart';
import 'package:maram/modules/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:maram/modules/cart/presentation/screens/checkout_screen.dart';
import 'package:maram/modules/cart/presentation/widgets/dialog_widgets.dart';

class ProductBottomSheet extends StatefulWidget {
  const ProductBottomSheet({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  int pieceQuantity = 1;
  int packetQuantity = 0;
  bool addingToCart = false;
  bool isBuing = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      height: MediaQuery.sizeOf(context).height * .88,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.product.name}',
                    style: labelStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: Text(
                      '[ ${widget.product.section} ]',
                      style: labelStyle?.copyWith(
                        color: myGreenColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.sizeOf(context).height / 4,
                width: MediaQuery.sizeOf(context).height / 4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.product.image!),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "القطعـة/ ",
                    style: labelStyle?.copyWith(
                      color: Colors.grey.shade400,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'ج.م ',
                    style: labelStyle?.copyWith(
                      color: myGreenColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.product.price}',
                    style: labelStyle?.copyWith(
                      color: myGreenColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "الباكيت/ ",
                    style: labelStyle?.copyWith(
                      color: Colors.grey.shade400,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'ج.م ',
                    style: labelStyle?.copyWith(
                      color: myGreenColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.product.packetPrice}',
                    style: labelStyle?.copyWith(
                      color: myGreenColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .9,
                    child: Text(
                      '${widget.product.description}',
                      style: labelStyle?.copyWith(fontSize: 16),
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "تفاصيل المنتج",
                    style: labelStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .9,
                    child: Text(
                      '${widget.product.details}',
                      style: labelStyle?.copyWith(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey.shade400, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "إضافة قطعة",
                        style: normalStyle?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "قطعة متبقية",
                            style: normalStyle?.copyWith(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${widget.product.quantity}',
                            style: normalStyle?.copyWith(
                              color: myGreenColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: pieceQuantity == 0
                            ? const WidgetStatePropertyAll(Colors.grey)
                            : const WidgetStatePropertyAll(myGreenColor)),
                    onPressed: () {
                      setState(() {
                        pieceQuantity == 0
                            ? pieceQuantity = 0
                            : pieceQuantity--;
                      });
                    },
                    icon: Text(
                      '-',
                      style: specialStyle?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(pieceQuantity.toString(), style: specialStyle),
                  IconButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(myGreenColor)),
                    onPressed: () {
                      setState(() {
                        pieceQuantity ==
                                int.parse(widget.product.quantity ?? '0')
                            ? pieceQuantity =
                                int.parse(widget.product.quantity ?? '0')
                            : pieceQuantity++;
                      });
                    },
                    icon: Text(
                      '+',
                      style: specialStyle?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "إضافة باكيـت",
                        style: normalStyle?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "باكيت متبقي",
                            style: normalStyle?.copyWith(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${widget.product.packetQuantity}',
                            style: normalStyle?.copyWith(
                              color: myGreenColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: packetQuantity == 0
                            ? const WidgetStatePropertyAll(Colors.grey)
                            : const WidgetStatePropertyAll(myGreenColor)),
                    onPressed: () {
                      setState(() {
                        packetQuantity == 0
                            ? packetQuantity = 0
                            : packetQuantity--;
                      });
                    },
                    icon: Text(
                      '-',
                      style: specialStyle?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(packetQuantity.toString(), style: specialStyle),
                  IconButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(myGreenColor)),
                    onPressed: () {
                      setState(() {
                        packetQuantity ==
                                int.parse(widget.product.packetQuantity ?? '0')
                            ? packetQuantity =
                                int.parse(widget.product.packetQuantity ?? '0')
                            : packetQuantity++;
                      });
                    },
                    icon: Text(
                      '+',
                      style: specialStyle?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 60),
              CustomizedButton(
                isLoading: isBuing,
                tittle: 'شراء الان',
                onTap: () async {
                  if (pieceQuantity == 0) {
                    showDialog(
                        context: context,
                        builder: (_) => const ErrorDialog(
                              error: 'يرجى اختيار قطعة',
                            ));
                    return;
                  } else {
                    setState(() {
                      isBuing = true;
                    });

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                          totalCost: pieceQuantity *
                                  double.parse(widget.product.price!) +
                              packetQuantity *
                                  double.parse(widget.product.packetPrice!),
                          deliveryCost: 25.0,
                          cartProducts: {
                            widget.product: [pieceQuantity, packetQuantity]
                          },
                        ),
                      ),
                    );
                    setState(() {
                      isBuing = false;
                    });
                  }
                },
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 120),
              CustomizedButtonWithBorder(
                isLoading: addingToCart,
                tittle: "اضافة للعربة",
                onTap: () async {
                  if (pieceQuantity == 0) {
                    showDialog(
                        context: context,
                        builder: (_) => const ErrorDialog(
                              error: 'يرجى اختيار قطعة',
                            ));
                    return;
                  } else {
                    setState(() {
                      addingToCart = true;
                    });
                    BlocProvider.of<CartCubit>(context).addProduct(
                        widget.product, pieceQuantity, packetQuantity);
                    await Future.delayed(const Duration(seconds: 1));
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    setState(() {
                      addingToCart = true;
                    });
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "تم الاضافة للعربة بنجاح",
                          style: labelStyle?.copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
