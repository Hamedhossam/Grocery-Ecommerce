import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/order_model.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    'ج.م ',
                    style: labelStyle?.copyWith(color: myGreenColor),
                  ),
                  Text(
                    orderModel.total,
                    style: labelStyle?.copyWith(color: myGreenColor),
                  ),
                ],
              ),
              Text(
                orderModel.status == 'تم التوصيل'
                    ? ' تم الدفع ✅'
                    : orderModel.paymentStatus,
                style: normalStyle?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                orderModel.orderCode,
                style: labelStyle,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .3,
                child: Text(
                  textDirection: TextDirection.rtl,
                  orderModel.createdAt,
                  style: normalStyle?.copyWith(),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .3,
                child: Text(
                  textDirection: TextDirection.rtl,
                  orderModel.status == 'تم التوصيل'
                      ? '${orderModel.status} ✅'
                      : orderModel.status,
                  style: normalStyle?.copyWith(
                      color: orderModel.status == 'تم التوصيل'
                          ? myGreenColor
                          : orderModel.status == 'جاري التجهيز'
                              ? const Color.fromARGB(255, 204, 183, 1)
                              : Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const CircleAvatar(
            backgroundColor: Color(0xffF5F5F5),
            radius: 40,
            backgroundImage: AssetImage('assets/icons/delivery_boy.png'),
          )
        ],
      ),
    );
  }
}
