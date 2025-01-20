import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/order_model.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/core/services/supabase_services.dart';
import 'package:maram/core/widgets/customized_botton.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:maram/modules/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:maram/modules/cart/presentation/widgets/dialog_widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen(
      {super.key,
      required this.totalCost,
      required this.deliveryCost,
      required this.cartProducts});

  final double totalCost;
  final double deliveryCost;
  final Map<ProductModel, List<int>> cartProducts;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PreferredSize buildCheckoutScreenAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.grey.shade500,
          shadowColor: Colors.grey.shade400,
          backgroundColor: const Color(0xffF5F5F5),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: Text(
            'الدفع',
            style: specialStyle,
          ),
        ),
      ),
    );
  }

  int? selectedValue = 1;
  String address =
      ' طنطا ثاني شارع البنداري بجوار كافيه بوليفيا محافظة الغربية';
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  bool editAddress = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    addressController.text = address;
    noteController.text = '';
  }
//! edit address not working
  // PersistentBottomSheetController editAddressBottomSheet(
  //   BuildContext context,
  //   String title,
  //   TextEditingController? controller,
  // ) {
  //   bool isLoading = false;
  //   return showBottomSheet(
  //       backgroundColor: Colors.white,
  //       context: context,
  //       builder: (_) {
  //         return Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: SizedBox(
  //             height: MediaQuery.sizeOf(context).height / 4,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: specialStyle,
  //                 ),
  //                 const SizedBox(height: 16),
  //                 CustomTextFormField(
  //                   hintText: title,
  //                   textInputType: TextInputType.text,
  //                   controller: controller,
  //                 ),
  //                 CustomizedButton(
  //                   isLoading: isLoading,
  //                   tittle: 'حفظ',
  //                   onTap: () {
  //                     setState(() {
  //                       isLoading = true; // Set loading to true
  //                     });
  //                     // Simulate a delay for saving the address
  //                     Future.delayed(const Duration(seconds: 1), () {
  //                       // After delay, update the address
  //                       setState(() {
  //                         address = controller!.text;
  //                         isLoading = false; // Reset loading state
  //                       });
  //                       Navigator.pop(context); // Close the bottom sheet
  //                     });
  //                   },
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: buildCheckoutScreenAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(myGreenColor),
                    ),
                    onPressed: () => setState(() {
                      editAddress = !editAddress;
                      address = addressController.text;
                    }),
                    child: Text(
                      editAddress ? 'حفظ' : 'تعديل',
                      style: labelStyle?.copyWith(
                          color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Text(
                    'عنوان التوصيل',
                    style: specialStyle?.copyWith(),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 75),
              editAddress
                  ? CustomTextFormField(
                      hintText: '',
                      textInputType: TextInputType.text,
                      onSaved: (p0) {},
                      controller: addressController,
                    )
                  : Text(
                      address,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: labelStyle?.copyWith(
                          fontSize: 16, color: Colors.grey),
                    ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 50),
              Divider(color: Colors.grey.shade500, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('طريقة الدفع', style: specialStyle?.copyWith()),
                ],
              ),
              Row(
                children: [
                  Radio<int>(
                    activeColor: myGreenColor,
                    value: 1, // Represents the first option
                    groupValue: selectedValue,
                    onChanged: (int? value) {
                      setState(() {
                        selectedValue = value; // Update the selected value
                      });
                    },
                  ),
                  const Spacer(
                    flex: 8,
                  ),
                  Text('الدفع عند الاستلام', style: lightStyle),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 10,
                    height: MediaQuery.sizeOf(context).width / 10,
                    child: Image.asset(
                      'assets/icons/cash.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<int>(
                    activeColor: myGreenColor,
                    value: 2, // Represents the second option
                    groupValue: selectedValue,
                    onChanged: (int? value) {
                      setState(() {
                        selectedValue = value; // Update the selected value
                      });
                    },
                  ),
                  const Spacer(
                    flex: 8,
                  ),
                  Text('الدفع بالبطاقة', style: lightStyle),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 10,
                    height: MediaQuery.sizeOf(context).width / 10,
                    child: Image.asset(
                      'assets/icons/credit_card.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey.shade500, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('إضافة ملاحظة', style: specialStyle?.copyWith()),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 75),
              CustomTextFormField(
                controller: noteController,
                hintText: '',
                textInputType: TextInputType.text,
                onSaved: (p0) {},
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 50),
              Divider(color: Colors.grey.shade500, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('تفاصيل الطلب', style: specialStyle?.copyWith()),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 75),
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
                        widget.totalCost.toString(),
                        style: labelStyle?.copyWith(
                            fontSize: 20, color: myGreenColor),
                      ),
                    ],
                  ),
                  Text(
                    'سعر المنتجات',
                    style: labelStyle?.copyWith(color: const Color(0xff9A9A9A)),
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
                        widget.deliveryCost.toString(),
                        style: labelStyle?.copyWith(
                            fontSize: 20, color: myGreenColor),
                      ),
                    ],
                  ),
                  Text(
                    'سعر التوصيل',
                    style: labelStyle?.copyWith(color: const Color(0xff9A9A9A)),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 9,
                    child: Divider(color: Colors.grey.shade500, thickness: 2),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 9,
                    child: Divider(color: Colors.grey.shade500, thickness: 2),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 9,
                    child: Divider(color: Colors.grey.shade500, thickness: 2),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 9,
                    child: Divider(color: Colors.grey.shade500, thickness: 2),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 9,
                    child: Divider(color: Colors.grey.shade500, thickness: 2),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 9,
                    child: Divider(color: Colors.grey.shade500, thickness: 2),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 9,
                    child: Divider(color: Colors.grey.shade500, thickness: 2),
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
                        (widget.totalCost + widget.deliveryCost).toString(),
                        style: labelStyle?.copyWith(
                            fontSize: 20, color: myGreenColor),
                      ),
                    ],
                  ),
                  Text(
                    'المبلغ الاجمالي',
                    style:
                        labelStyle?.copyWith(fontSize: 20, color: myGreenColor),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 50),
              CustomizedButton(
                isLoading: isLoading,
                tittle: 'تأكيد الطلب',
                onTap: () async {
                  isLoading ? null : setState(() => isLoading = true);
                  try {
                    await SupabaseServices.buyProducts(widget.cartProducts);
                    List<String> images = [];
                    for (var product in widget.cartProducts.keys) {
                      images.add(product.image!);
                    }
                    String orderCode = generateRandom6DigitNumber();
                    String orderDate = getFormattedDateTime();
                    await SupabaseServices.createOrder(
                      OrderModel(
                        userId: Supabase.instance.client.auth.currentUser!.id,
                        createdAt: orderDate,
                        status: 'جاري التجهيز',
                        paymentMethod:
                            selectedValue == 1 ? 'كاش' : 'كارت الدفع',
                        paymentStatus: 'لم يتم الدفع',
                        deliveryMethod: selectedValue == 1 ? 'توصيل' : 'استلام',
                        total:
                            (widget.totalCost + widget.deliveryCost).toString(),
                        note: noteController.text,
                        productsImages: images,
                        orderCode: orderCode,
                        deliveryAddress: addressController.text,
                      ),
                    );
                    await showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (builder) => SuccessDialog(
                              orderCode: orderCode,
                              message:
                                  'تم تأكيد الطلب بنجاح يمكنك متابعة الطلبات في صفحة الطلبات كود الطلب',
                            ));
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<CartCubit>(context).clearCart();
                    await Future.delayed(const Duration(seconds: 1));
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } on Exception catch (e) {
                    log(e.toString());
                    await showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (builder) => const ErrorDialog(
                        error: 'حدث خطأ يرجى المحاولة مرة اخرى',
                      ),
                    );
                  }
                  setState(() => isLoading = false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
