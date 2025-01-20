import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:maram/constants.dart';
import 'package:maram/modules/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:maram/modules/cart/presentation/widgets/cart_screen_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  PreferredSize buildCartScreenAppBar(BuildContext context) {
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
          // leading: IconButton(
          //   onPressed: () => Navigator.pop(context),
          //   icon: const Icon(Icons.arrow_back_ios_rounded),
          // ),
          title: Text(
            'العربة',
            style: specialStyle,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: buildCartScreenAppBar(context),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset('assets/lotties/empty_cart.json',
                    height: MediaQuery.sizeOf(context).height / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لا يوجد منتجات في العربة',
                      style: specialStyle?.copyWith(color: myGreenColor),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is CartLoaded) {
            return CartScreenView(cartProducts: state.cartProducts);
          } else {
            return Center(
              child: Text('error  !!',
                  style: labelStyle?.copyWith(fontWeight: FontWeight.bold)),
            );
          }
        },
      ),
    );
  }
}
