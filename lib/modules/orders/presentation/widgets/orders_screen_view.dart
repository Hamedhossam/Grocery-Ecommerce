import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/order_model.dart';
import 'package:maram/modules/orders/presentation/widgets/order_widget.dart';

class OrdersScreenView extends StatefulWidget {
  const OrdersScreenView({super.key, required this.orders});
  final List<OrderModel> orders;

  @override
  State<OrdersScreenView> createState() => _OrdersScreenViewState();
}

class _OrdersScreenViewState extends State<OrdersScreenView> {
  late List<DropdownMenuItem<String>> items;
  String selectedValue = "all";
  late List<OrderModel> filteredorders;
  @override
  void initState() {
    super.initState();
    filteredorders = widget.orders;
    items = [
      DropdownMenuItem(
        value: "all",
        onTap: () {
          setState(() {
            filteredorders = widget.orders;
          });
        },
        child: const Text("جميع الطلبات"),
      ),
      DropdownMenuItem(
        value: "onWay",
        onTap: () {
          setState(() {
            filteredorders = widget.orders
                .where((element) => element.status == "في الطريق")
                .toList();
          });
        },
        child: const Text("قيد التوصيل"),
      ),
      DropdownMenuItem(
        value: "delivered",
        onTap: () {
          setState(() {
            filteredorders = widget.orders
                .where((element) => element.status == "تم التوصيل")
                .toList();
          });
        },
        child: const Text("تم التوصيل"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 117, 116, 116),
                      width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton(
                    items: items,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                    value: selectedValue,
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color.fromARGB(255, 117, 116, 116),
                    ),
                  ),
                ),
              ),
              Text("عرض الطلبات حسب", style: labelStyle),
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .75,
            child: ListView.builder(
              itemCount: filteredorders.length,
              itemBuilder: (context, index) =>
                  OrderWidget(orderModel: filteredorders[index]),
            ),
          ),
        ],
      ),
    );
  }
}
