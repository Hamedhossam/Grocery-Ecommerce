import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/order_model.dart';
import 'package:maram/modules/orders/logic/orders_cubit/orders_cubit.dart';
import 'package:maram/modules/orders/presentation/widgets/orders_screen_view.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  PreferredSize buildMyOrdersAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.grey.shade300,
          shadowColor: Colors.grey.shade400,
          backgroundColor: const Color(0xffF5F5F5),
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () => Navigator.pop(context),
          //   icon: const Icon(Icons.arrow_back_ios_rounded),
          // ),
          title: Text(
            'طلباتي',
            style: specialStyle,
          ),
        ),
      ),
    );
  }

  late List<OrderModel> orders;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrdersCubit>(context).fetchOrders();
    orders = BlocProvider.of<OrdersCubit>(context).orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: buildMyOrdersAppBar(context),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return Center(
              child: LottieBuilder.asset('assets/lotties/shopping_cart.json',
                  height: MediaQuery.sizeOf(context).height / 2),
            );
          } else if (state is OrdersEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset('assets/lotties/empty_orders.json',
                    height: MediaQuery.sizeOf(context).height / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لا يوجد طلبات حتى الان',
                      style: specialStyle?.copyWith(color: myGreenColor),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is OrdersLoaded) {
            return OrdersScreenView(orders: state.orders);
          } else {
            return Center(
              child: Text('خطأ في تحميل الطلبات',
                  style: labelStyle?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.red)),
            );
          }
        },
      ),
    );
  }
}
