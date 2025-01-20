import 'package:flutter/material.dart';
import 'package:maram/constants.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog(
      {super.key, required this.message, required this.orderCode});
  final String message;
  final String orderCode;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            orderCode,
            style: labelStyle?.copyWith(
                fontWeight: FontWeight.bold, color: myGreenColor),
          ),
          Text(
            ' : كود الطلب',
            style: labelStyle,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: myGreenColor,
            size: 50,
          ),
          Text(
            message,
            style: labelStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 50,
          ),
          Text(
            error,
            style: labelStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
