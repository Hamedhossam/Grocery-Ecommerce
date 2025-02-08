import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/order_model.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/core/services/supabase_services.dart';
import 'package:maram/modules/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:maram/modules/cart/presentation/widgets/dialog_widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.paymentToken,
    required this.cartProducts,
    required this.totalCost,
    required this.note,
    required this.address,
  });
  final String? paymentToken;
  final Map<ProductModel, List<int>> cartProducts;
  final double totalCost;
  final String note;
  final String address;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  InAppWebViewController? webViewController;
  void pay() async {
    await webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
          'https://accept.paymob.com/api/acceptance/iframes/898809?payment_token=${Uri.encodeComponent(widget.paymentToken!)}',
        ),
      ),
    );
  }

  Future<void> checkOut(
      BuildContext context, Map<ProductModel, List<int>> products) async {
    try {
      await SupabaseServices.buyProducts(products);
      List<String> images = [];
      for (var product in products.keys) {
        images.add(product.image!);
      }
      String orderCode = generateRandom6DigitNumber();
      String orderDate = getFormattedDateTime();
      await SupabaseServices.createOrder(
        OrderModel(
          userId: Supabase.instance.client.auth.currentUser!.id,
          createdAt: orderDate,
          status: 'جاري التجهيز',
          paymentMethod: 'كارت الدفع',
          paymentStatus: 'تم الدفع',
          deliveryMethod: 'توصيل',
          total: (widget.totalCost).toString(),
          note: widget.note,
          productsImages: images,
          orderCode: orderCode,
          deliveryAddress: widget.address,
        ),
      );
      await showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (builder) => SuccessDialog(
                orderCode: orderCode,
                message:
                    'تم تأكيد الدفع بنجاح يمكنك متابعة الطلبات في صفحة الطلبات',
              ));
      // ignore: use_build_context_synchronously
      BlocProvider.of<CartCubit>(context).clearCart();
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
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webViewController = controller;
          pay(); // Call pay() here after the web view is created
        },
        onLoadStop: (controller, url) async {
          if (url != null) {
            if (url.queryParameters.containsKey('success')) {
              if (url.queryParameters['success'] == 'true') {
                log('Payment success');
                await checkOut(context, widget.cartProducts);
              } else if (url.queryParameters['success'] == 'false') {
                log('Payment failed');
                // Navigate or show a failure dialog
              }
            }
          }
        },
        onLoadError: (controller, url, code, message) {
          log('Load error: $message');
        },
      ),
      // body: InAppWebView(
      //   // ignore: deprecated_member_use
      //   initialOptions: InAppWebViewGroupOptions(
      //     // ignore: deprecated_member_use
      //     crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
      //   ),
      //   onWebViewCreated: (InAppWebViewController controller) {
      //     webViewController = controller;
      //   },
      //   onLoadStop: (controller, url) {
      //     if (url != null &&
      //         url.queryParameters.containsKey('success') &&
      //         url.queryParameters['success'] == 'true') {
      //       log('payment success');
      //     } else if (url != null &&
      //         url.queryParameters.containsKey('success') &&
      //         url.queryParameters['success'] == 'false') {
      //       log('payment failed');
      //     }
      //   },
      // ),
    );
  }
}
